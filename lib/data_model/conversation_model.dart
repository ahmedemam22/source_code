// To parse this JSON data, do
//
//     final conversationModel = conversationModelFromJson(jsonString);

import 'dart:convert';

ConversationModel conversationModelFromJson(String str) => ConversationModel.fromJson(json.decode(str));

String conversationModelToJson(ConversationModel data) => json.encode(data.toJson());

class ConversationModel {
  ConversationModel({
    this.result,
    this.conversationId,
    this.shopName,
    this.shopLogo,
    this.title,
    this.message,
  });

  bool result;
  int conversationId;
  String shopName;
  dynamic shopLogo;
  String title;
  String message;

  factory ConversationModel.fromJson(Map<String, dynamic> json) => ConversationModel(
    result: json["result"],
    conversationId: json["conversation_id"],
    shopName: json["shop_name"],
    shopLogo: json["shop_logo"],
    title: json["title"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "conversation_id": conversationId,
    "shop_name": shopName,
    "shop_logo": shopLogo,
    "title": title,
    "message": message,
  };
}
