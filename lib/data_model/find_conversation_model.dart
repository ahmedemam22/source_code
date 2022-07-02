// To parse this JSON data, do
//
//     final findConversationModel = findConversationModelFromJson(jsonString);

import 'dart:convert';

import 'package:active_ecommerce_flutter/data_model/data_message_model.dart';

FindConversationModel findConversationModelFromJson(String str) => FindConversationModel.fromJson(json.decode(str));

String findConversationModelToJson(FindConversationModel data) => json.encode(data.toJson());

class FindConversationModel {
  FindConversationModel({
    this.conversations,
  });

  List<Conversation> conversations;

  factory FindConversationModel.fromJson(Map<String, dynamic> json) => FindConversationModel(
    conversations: List<Conversation>.from(json["conversations"].map((x) => Conversation.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "conversations": List<dynamic>.from(conversations.map((x) => x.toJson())),
  };
}

class Conversation {
  Conversation({
    this.conversationId,
    this.sender,
    this.shopName,
    this.shopLogo,
    this.receiver,
    this.messages,
  });

  int conversationId;
  int sender;
  String shopName;
  dynamic shopLogo;
  int receiver;
  Messages messages;

  factory Conversation.fromJson(Map<String, dynamic> json) => Conversation(
    conversationId: json["Conversation ID"],
    sender: json["Sender"],
    shopName: json['shop_name'],
    shopLogo: json["Shop Logo"],
    receiver: json["Receiver"],
    messages: Messages.fromJson(json["messages"]),
  );

  Map<String, dynamic> toJson() => {
    "Conversation ID": conversationId,
    "Sender": sender,
    "Shop Name": ['shop_name'],
    "Shop Logo": shopLogo,
    "Receiver": receiver,
    "messages": messages.toJson(),
  };
}

class Messages {
  Messages({
    this.data,
  });

  List<DataMessageModel> data;

  factory Messages.fromJson(Map<String, dynamic> json) => Messages(
    data: List<DataMessageModel>.from(json["data"].map((x) => DataMessageModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

