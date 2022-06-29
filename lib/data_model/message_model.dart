// To parse this JSON data, do
//
//     final messageModel = messageModelFromJson(jsonString);

import 'dart:convert';

MessageModel messageModelFromJson(String str) => MessageModel.fromJson(json.decode(str));

String messageModelToJson(MessageModel data) => json.encode(data.toJson());

class MessageModel {
  MessageModel({
    this.senderId,
    this.message,
  });

  int senderId;
  Message message;

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
    senderId: json["sender_id"],
    message: Message.fromJson(json["message"]),
  );

  Map<String, dynamic> toJson() => {
    "sender_id": senderId,
    "message": message.toJson(),
  };
}

class Message {
  Message({
    this.conversationId,
    this.userId,
    this.type,
    this.message,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.conversation,
  });

  String conversationId;
  int userId;
  String type;
  String message;
  DateTime updatedAt;
  DateTime createdAt;
  int id;
  Conversation conversation;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    conversationId: json["conversation_id"],
    userId: json["user_id"],
    type: json["type"],
    message: json["message"],
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    id: json["id"],
    conversation: Conversation.fromJson(json["conversation"]),
  );

  Map<String, dynamic> toJson() => {
    "conversation_id": conversationId,
    "user_id": userId,
    "type": type,
    "message": message,
    "updated_at": updatedAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "id": id,
    "conversation": conversation.toJson(),
  };
}

class Conversation {
  Conversation({
    this.id,
    this.senderId,
    this.receiverId,
    this.title,
    this.senderViewed,
    this.receiverViewed,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int senderId;
  int receiverId;
  String title;
  int senderViewed;
  int receiverViewed;
  DateTime createdAt;
  DateTime updatedAt;

  factory Conversation.fromJson(Map<String, dynamic> json) => Conversation(
    id: json["id"],
    senderId: json["sender_id"],
    receiverId: json["receiver_id"],
    title: json["title"],
    senderViewed: json["sender_viewed"],
    receiverViewed: json["receiver_viewed"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sender_id": senderId,
    "receiver_id": receiverId,
    "title": title,
    "sender_viewed": senderViewed,
    "receiver_viewed": receiverViewed,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
