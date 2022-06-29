import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import '../data_model/message_model.dart';
import '../data_model/conversation_model.dart';

import '../network/api.dart';
import '../network/const.dart';

class MessageProvider extends ChangeNotifier{
  MessageModel _messageModel;
  ConversationModel _conversationModel;
  get messageModel=>_messageModel;
  get conversationModel=>_conversationModel;
Future sendMessage(String message)async{
  var response=await api.postWithBody(BASEURL+MESSAGEURL,
    {
    "conversation_id": "4",
    "message": message,
    "type": "text"
    },);
  _messageModel=MessageModel.fromJson(jsonDecode(response.body));
  notifyListeners();
  print("dataaaaaaaaaaaaa--->${_messageModel.message.message}");


}
  Future createConversation(String message,String product_id)async{
    var response=await api.postWithBody(BASEURL+CREATECONVERSATION,
      {
        "product_id": product_id,
        "title": "Buy",
        "type": message
      },);
    _conversationModel=ConversationModel.fromJson(jsonDecode(response.body));
    notifyListeners();
    print("dataaaaaaaaaaaaa--->${_conversationModel.conversationId}");


  }
  Future uploadImage(File image)async{
    var response=await api.uploadImage(MESSAGEURL,image);

    notifyListeners();


  }
}