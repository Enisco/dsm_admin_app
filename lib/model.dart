import 'dart:convert';

LimitDataModel limitDataModelFromJson(String str) => LimitDataModel.fromJson(json.decode(str));

String limitDataModelToJson(LimitDataModel data) => json.encode(data.toJson());

class LimitDataModel {
    final int? limit;

    LimitDataModel({
        this.limit,
    });

    LimitDataModel copyWith({
        int? limit,
    }) => 
        LimitDataModel(
            limit: limit ?? this.limit,
        );

    factory LimitDataModel.fromJson(Map<String, dynamic> json) => LimitDataModel(
        limit: json["limit"],
    );

    Map<String, dynamic> toJson() => {
        "limit": limit,
    };
}
