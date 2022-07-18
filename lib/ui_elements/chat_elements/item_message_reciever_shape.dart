import 'package:active_ecommerce_flutter/data_model/data_message_model.dart';
import 'package:flutter/material.dart';
import 'package:loading_gifs/loading_gifs.dart';

import '../../data_model/one_conversation_model.dart';

class ItemMessageReceiverShape extends StatelessWidget {
  final DataMessageModel  message;
  final String photo;
 // final ChatProvider chatProvider;
  const ItemMessageReceiverShape(
      {Key key,
         this.message,
         this.photo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, top: 20, bottom: 10,right: 100),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        CircleAvatar(
          backgroundImage: NetworkImage(photo),
          radius: 17,
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.all(11.0),
              child: message.type=='text'?Text(
                message.message,
                style: TextStyle(color: Colors.black, fontSize: 15),)
                    :message.sendImageByMe?Image.file(message.message,width: 150,height: 250,fit: BoxFit.fill,):FadeInImage.assetNetwork(placeholder: cupertinoActivityIndicator, image: message.message, placeholderScale: 5,
                width: 200,height: 250,
    ),
          ),
          ),
        )]),
    );
  }
}