import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pusher_websocket_flutter/pusher.dart';


import 'package:pusher_websocket_flutter/pusher.dart';
class PusherCreating{
Channel _channel;

Future<void>initPusher()async{
  //init
  try{
    await Pusher.init("2eacad1d9769ffeeb634",PusherOptions(cluster: "mt1"));
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
  _channel=await Pusher.subscribe('conversation-4');
//bind
  await _channel.bind('new-message', (onEvent) {
    /*if(mounted){
      final data=json.decode(onEvent.data);
      _item.add([data['name'],data['message']]);
      print("itemssssss${_item[0][0]}");
      setState(() {
      });
    }*/
    print("event data----->${onEvent.data}");

  });


}}