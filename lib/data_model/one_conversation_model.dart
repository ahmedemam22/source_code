// To parse this JSON data, do
//
//     final oneConversationModel = oneConversationModelFromJson(jsonString);

import 'dart:convert';

import 'package:active_ecommerce_flutter/data_model/data_message_model.dart';

OneConversationModel oneConversationModelFromJson(String str) => OneConversationModel.fromJson(json.decode(str));

String oneConversationModelToJson(OneConversationModel data) => json.encode(data.toJson());

class OneConversationModel {
  OneConversationModel({
    this.data,
    this.success,
    this.status,
  });

  List<DataMessageModel> data;
  bool success;
  int status;

  factory OneConversationModel.fromJson(Map<String, dynamic> json) => OneConversationModel(
    data: List<DataMessageModel>.from(json["data"].map((x) => DataMessageModel.fromJson(x))),
    success: json["success"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "success": success,
    "status": status,
  };
}

