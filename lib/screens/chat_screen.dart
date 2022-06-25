
import 'package:flutter/material.dart';

import '../ui_elements/chat_shape.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 5),
        child:

          ListView.builder(
                  itemCount: 5,
                  itemBuilder: (BuildContext context,int index){
                    return ChatShape();
                  }),
            ),



    );
  }
}