import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pusher_websocket_flutter/pusher.dart';
class Training extends StatefulWidget {
  const Training({Key key}) : super(key: key);

  @override
  State<Training> createState() => _TrainingState();
}

class _TrainingState extends State<Training> {
  List<List<String>>_item=[];
  Channel _channel;
  @override
  initState(){
    super.initState();
    _initPusher();


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat"),
      ),
      body: Padding(
        padding:  EdgeInsets.all(20.0),
        child: ListView.builder(itemBuilder: (BuildContext context,int i){
          return Column(children: [
            Text(_item[i][0]),
            Text(_item[i][1]),
          ],);

        },
        itemCount: _item.length,
        ),
      ),
    );
  }
  Future<void>_initPusher()async{
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
_channel=await Pusher.subscribe('name_channel');
//bind
await _channel.bind('name_event', (onEvent) {
  if(mounted){
    final data=json.decode(onEvent.data);
    _item.add([data['name'],data['message']]);
    print("itemssssss${_item[0][0]}");
    setState(() {
    });
  }
  print("event data----->${onEvent.data}");

});


  }
}
