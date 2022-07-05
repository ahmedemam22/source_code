import 'package:active_ecommerce_flutter/screens/message_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../data_model/user_conversation_with_last_msg_model.dart';
class ChatShape extends StatelessWidget {
  const ChatShape({Key key, this.conversation}) : super(key: key);
  final Conversation conversation;

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: ()=>Navigator.push(context,
          MaterialPageRoute(builder: (context) {
            return MessageScreen(shopName: conversation.shopName??'',conversationtId: conversation.conversationId,shopImage: conversation.shopLogo ,);
          }))
      ,
      child: Column(
        children: [
          ListTile(
            selected: conversation.messages.data.length!=0?!conversation.messages.data[0].seen:false,
            leading: CircleAvatar(
              radius: 18,
              child: ClipOval(
                child: Image.network(
                  conversation.shopLogo??'',
                ),
              ),
            ),
            title: Text(conversation.shopName),
            subtitle: conversation.messages.data.length==0?Text(''):Text(conversation.messages.data[0].type=='file'?'pic...':conversation.messages.data[0].message,
              style: TextStyle(
                  overflow: TextOverflow.ellipsis
              ),),
            trailing:  conversation.messages.data.length==0?Text(''):Text(conversation.messages.data[0].date)),


          Divider(thickness:1 ,)
        ],
      ),

    );
  }
}