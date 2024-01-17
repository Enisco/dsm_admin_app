import 'package:dsm_admin_app/controller.dart';
import 'package:dsm_admin_app/widget/custom_button.dart';
import 'package:dsm_admin_app/widget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = Get.put(HomepageController());

  @override
  void initState() {
    super.initState();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    _controller.getSetLimit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          "Set Power Limit",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () => SystemChannels.textInput.invokeMethod('TextInput.hide'),
        child: GetBuilder<HomepageController>(
          init: _controller,
          builder: (_) {
            return Container(
              padding: const EdgeInsets.all(24),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Initial Limit Set: ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          _controller.setLimit != null
                              ? "${_controller.setLimit.toString()} Watts"
                              : "Undefined",
                          style: const TextStyle(
                            color: Colors.teal,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    CustomTextfield(
                      textEditingController: _controller.limitController,
                      labelText: 'Set New Limit',
                      hintText: 'Set new power limit (in Watts)',
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 40),
                    CustomButton(
                      width: 200,
                      color: Colors.teal,
                      child: const Text(
                        "Update",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                      onPressed: () {
                        SystemChannels.textInput.invokeMethod('TextInput.hide');
                        _controller.validateInput();
                      },
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
