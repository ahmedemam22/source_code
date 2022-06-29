import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import '../data_model/message_model.dart';
import '../network/api.dart';
import '../network/const.dart';

class MessageProvider extends ChangeNotifier{
  MessageModel _messageModel;
  get messageModel=>_messageModel;
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
  Future createConversation(String message)async{
    var response=await api.postWithBody(BASEURL+CREATECONVERSATION,
      {
        "product_id": "9",
        "title": "islam",
        "type": "text"
      },);
    _messageModel=MessageModel.fromJson(jsonDecode(response.body));
    notifyListeners();
    print("dataaaaaaaaaaaaa--->${_messageModel.message.message}");


  }
  Future uploadImage(File image)async{
    var response=await api.uploadImage(MESSAGEURL,image);

    notifyListeners();


  }
}