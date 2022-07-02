import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:active_ecommerce_flutter/ui_elements/chat_elements/item_message_sender_shape.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/message_provider.dart';
import 'item_message_reciever_shape.dart';
class ChatBody extends StatelessWidget {
  final dynamic shopImage;
  final int conversationId;
   ChatBody({Key key, this.shopImage, this.conversationId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<MessageProvider>(
        builder: (_, message, child) {
          return
            ListView.builder(
                controller: message.scrollController,
                itemCount: message.oneConversationModel.data!=null?message.oneConversationModel.data.length:0,
                itemBuilder: (context, index) {
                  return  message.oneConversationModel.data[index].userId==user_id.$ ?
                  ItemMessageSenderShape(
                    message: message.oneConversationModel.data[index],last: index==message.oneConversationModel.data.length-1,) :
                  ItemMessageReceiverShape(
                    message: message.oneConversationModel.data[index],
                    photo:shopImage??'' ,
                  );
                });
        });
  }
}
