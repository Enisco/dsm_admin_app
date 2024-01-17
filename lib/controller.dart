// ignore_for_file: avoid_print

import 'package:dsm_admin_app/model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class HomepageController extends GetxController {
  static HomepageController get to => Get.find();

  TextEditingController limitController = TextEditingController();

  bool loading = false;
  int? setLimit;

  validateInput() {
    if (limitController.text.trim().isNotEmpty == true) {
      try {
        int.parse(limitController.text.trim());
        updateLimitData();
      } catch (e) {
        Fluttertoast.showToast(msg: "Enter a valid integer");
        limitController.clear();
      }
    }
  }

  Future<void> getSetLimit() async {
    final limitDataRef = FirebaseDatabase.instance.ref("nath");

    limitDataRef.onChildAdded.listen(
      (event) {
        print("Received: ${event.snapshot.value}");
        setLimit = int.parse(event.snapshot.value.toString());
        print("Set Limit: $setLimit");
        update();
      },
    );
    loading = false;
    update();
  }

  updateLimitData() async {
    int newLimit = int.parse(limitController.text.trim());

    LimitDataModel newLimitData = LimitDataModel(limit: newLimit);
    print(" >>>>>>> Limit set is ${newLimitData.toJson()}");

    DatabaseReference ref = FirebaseDatabase.instance.ref("nath");

    await ref.update(newLimitData.toJson()).whenComplete(() async {
      print("Data updated");
      Fluttertoast.showToast(msg: "Limit value updated");
      setLimit = newLimit;
      limitController.clear();
      update();
    });
    loading = false;
    update();
  }
}
