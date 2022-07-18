import 'dart:convert';
import 'dart:io';

import 'package:active_ecommerce_flutter/data_model/find_conversation_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import '../data_model/message_model.dart';
import '../data_model/conversation_model.dart';

import '../data_model/one_conversation_model.dart';
import '../data_model/user_conversation_with_last_msg_model.dart';
import '../helpers/shared_value_helper.dart';
import '../network/api.dart';
import '../network/const.dart';
import '../services/pusher.dart';

class MessageProvider extends ChangeNotifier{
  final _chatInputController = new TextEditingController();
  get chatInputController=>_chatInputController;




  MessageModel _messageModel;
  ConversationModel _conversationModel;
  FindConversationModel _findConversationModel=FindConversationModel();
  UserConversationWithLastMsgModel _userConversationWithLastMsgModel;
  OneConversationModel _oneConversationModel;
  bool _oneConversationLoading=false;
  bool _findConversationLoading=false;
  get oneConversationLoading=>_oneConversationLoading;
  get findConversationLoading=>_findConversationLoading;
  get oneConversationModel=>_oneConversationModel;
  get findConversationModel=>_findConversationModel;
  get messageModel=>_messageModel;
  get userConversationWithLastMsgModel=>_userConversationWithLastMsgModel;
  get conversationModel=>_conversationModel;

Future sendMessage(String message,conversationtId)async{
 try{

    int convId;
    if(conversationtId==-1)convId=_conversationModel.conversationId;
    else convId=int.parse(conversationtId);
    print(convId);
    print("iddddddddd");

   var response=await api.postWithBody(BASEURL+MESSAGEURL,
     {
       "conversation_id": convId.toString(),
       "message": message,
       "type": "text"
     },);
   print(jsonDecode(response.body));
   print("sennnnnnnnnnd0");
   _messageModel=MessageModel.fromJson(jsonDecode(response.body));
 }
  catch(e) {
  print("send message erro===>$e");
  }
  notifyListeners();
 // print("dataaaaaaaaaaaaa--->${_messageModel.message.message}");


}
  Future createConversation(dynamic message,String product_id,String type,context)async{
    try{
      print('prodddddddddddd$product_id');
      var response=await api.postWithBody(BASEURL+CREATECONVERSATION,
        {
          "product_id": product_id,
          "title": "Buy",
          "message": message,
          "type": type
        },);
      _conversationModel=ConversationModel.fromJson(jsonDecode(response.body));
      PusherCreating().initPusher(_conversationModel.conversationId,context);

    }
    catch(e) {
    print(e);
    }
    notifyListeners();
    print("dataaaaaaaaaaaaa--->${_conversationModel.conversationId}");


  }
   Future findConversation(String sellerId)async{
     _findConversationLoading=true;
     notifyListeners();
  _oneConversationModel=OneConversationModel(data: []);
  print("user id====>${user_id.$.toString()}");
  print("seller id====>${sellerId}");
     try{
       var response=await api.postWithBody(BASEURL+FINDCONVERSATION,
         {
           "user_id": user_id.$.toString(),
           "seller_id": sellerId,

         },);
      if(jsonDecode(response.body)['conversations'].length>0){ _findConversationModel=FindConversationModel.fromJson(jsonDecode(response.body));
      if(_findConversationModel.conversations!=null){ _oneConversationModel.data=_findConversationModel.conversations[0].messages.data;
       _conversationModel.conversationId=_findConversationModel.conversations[0].conversationId;
     }}}
     catch(e) {
       print("find conversation error-->$e");
     }
     _findConversationLoading=false;

     notifyListeners();
    // print("dataaaaaaaaaaaaa--->${_findConversationModel.conversations[0].conversationId}");


   }
  Future getConversationWithLastMsg()async{
    try {
      var response = await api.postWithBody(BASEURL + CONVERSATIONWITHLASTMSG,
        {
          "user_id": user_id.$.toString(),

        },);

      _userConversationWithLastMsgModel =
          UserConversationWithLastMsgModel.fromJson(jsonDecode(response.body));
    }
    catch(e) {
      print(e);
    }
      notifyListeners();
      print("user conversation with last msg--->${_userConversationWithLastMsgModel.conversations[0].messages}");
    }



  Future getOneConversation(int conversationId )async{

    _oneConversationLoading=true;
    notifyListeners();

    try {
    var response = await api.get(BASEURL + ONECONVERSATION + '$conversationId');
    _oneConversationModel = OneConversationModel.fromJson(response);
  }
  catch(e){
    print(e);
  }
    _findConversationModel=FindConversationModel();
    _oneConversationLoading=false;
    notifyListeners();


  }
  Future uploadImageForSecondCon(File image,conversationId)async{
  try{
    var response=await api.uploadImage(BASEURL+MESSAGEURL,image,conversationId,FormData.fromMap({
      "conversation_id":conversationId.toString(),
      "type":"file",
      "message":
      await MultipartFile.fromFile(image.path, filename:image.path.split('/').last),
    }));}
catch(e){
  print(e);
}
    notifyListeners();
  }
   Future uploadImageForFirstCon(File image,productId)async{
     try{
       var response=await api.uploadImage(BASEURL+CREATECONVERSATION,image,productId,FormData.fromMap({
         "product_id":productId.toString(),
         "type":"file",
         "message":
         await MultipartFile.fromFile(image.path, filename:image.path.split('/').last),
       }));}
     catch(e){
       print(e);
     }
     notifyListeners();
   }

  addConversation( item){
  _chatInputController.text='';
  print(_oneConversationModel.data.length);
  _oneConversationModel.data.add(item);
  //scrollToDown(controller);
  notifyListeners();
  }
scrollToDown(controller){


  notifyListeners();
}
changeSeen(int index){
  _userConversationWithLastMsgModel.conversations[index].messages.data.forEach((element) {element.seen=true;});
}


}