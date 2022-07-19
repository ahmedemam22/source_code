
import 'package:active_ecommerce_flutter/providers/message_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../ui_elements/chat_shape.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final messageProvider=Provider.of<MessageProvider>(context,listen: false);
     return FutureBuilder<dynamic>(
    future:messageProvider.getConversationWithLastMsg() , // function where you call your api
    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {  // AsyncSnapshot<Your object type>
    if( snapshot.connectionState == ConnectionState.waiting){
    return  Center(child: CircularProgressIndicator());
    }else{
    if (snapshot.hasError)
    return Center(child: Text('please check your internet'));
    else
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 5),
      child:

      ListView.builder(
          itemCount: messageProvider.userConversationWithLastMsgModel!=null?messageProvider.userConversationWithLastMsgModel.conversations.length:0,
          itemBuilder: (BuildContext context,int index){
            return ChatShape(conversation:messageProvider.userConversationWithLastMsgModel.conversations[index],index:index);
          }),




    );
       // snapshot.data  :- get your object which is pass from your downloadData() function
    }
    },
    );
  }

}