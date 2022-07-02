// To parse this JSON data, do
//
//     final userConversationWithLastMsgModel = userConversationWithLastMsgModelFromJson(jsonString);

import 'dart:convert';

UserConversationWithLastMsgModel userConversationWithLastMsgModelFromJson(String str) => UserConversationWithLastMsgModel.fromJson(json.decode(str));

String userConversationWithLastMsgModelToJson(UserConversationWithLastMsgModel data) => json.encode(data.toJson());

class UserConversationWithLastMsgModel {
  UserConversationWithLastMsgModel({
    this.conversations,
  });

  List<Conversation> conversations;

  factory UserConversationWithLastMsgModel.fromJson(Map<String, dynamic> json) => UserConversationWithLastMsgModel(
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
    shopName: json["Shop Name"],
    shopLogo: json["Shop Logo"],
    receiver: json["Receiver"],
    messages: Messages.fromJson(json["messages"]),
  );

  Map<String, dynamic> toJson() => {
    "Conversation ID": conversationId,
    "Sender": sender,
    "Shop Name": shopName,
    "Shop Logo": shopLogo,
    "Receiver": receiver,
    "messages": messages.toJson(),
  };
}

class Messages {
  Messages({
    this.data,
  });

  List<Datum> data;

  factory Messages.fromJson(Map<String, dynamic> json) => Messages(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.userId,
    this.message,
    this.seen,
    this.type,
    this.date,
    this.time,
  });

  int id;
  int userId;
  String message;
  bool seen;
  String type;
  String date;
  String time;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    userId: json["user_id"],
    message: json["message"],
    seen: json["seen"],
    type: json["type"],
    date: json["date"],
    time: json["time"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "message": message,
    "seen": seen,
    "type": type,
    "date": date,
    "time": time,
  };
}
