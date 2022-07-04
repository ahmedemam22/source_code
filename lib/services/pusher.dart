import 'dart:convert';

import 'package:active_ecommerce_flutter/data_model/message_model.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:active_ecommerce_flutter/providers/message_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:pusher_websocket_flutter/pusher.dart';


import 'package:pusher_websocket_flutter/pusher.dart';

import '../data_model/data_message_model.dart';
import '../data_model/one_conversation_model.dart';
class PusherCreating{
Channel _channel;

Future<void>initPusher(int conversationId,context)async{
  //init
  try{
    await Pusher.init("fc960958dc08dd154083",PusherOptions(cluster: "eu"));
  }
  catch(e){
    print("pusher init error----->$e");
  }
//connect
  await Pusher.connect(onConnectionStateChange: (state) {
    print("current state-----> ${state.currentState}");

  },
      onError: (err) {
        print("pusher connect error-----> $err");
      }
  );
  //subscribe
  _channel=await Pusher.subscribe('conversation-$conversationId');
//bind
  await _channel.bind('new-message', (onEvent) {
    //if(mounted){
      final data=json.decode(onEvent.data);
      if(user_id.$!=data['sender_id'])Provider.of<MessageProvider>(context,listen: false).addConversation(DataMessageModel(userId:data['sender_id'] ,message:data['message']['message'],type: data['message']['type'] ,date:  new DateFormat("dd-MM-y").format(data['message']['created_at'])));


    //}
    print("event data----->${onEvent.data}");

  });


}}