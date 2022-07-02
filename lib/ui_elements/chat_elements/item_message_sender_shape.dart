import 'package:active_ecommerce_flutter/data_model/one_conversation_model.dart';
import 'package:flutter/material.dart';
import 'package:loading_gifs/loading_gifs.dart';

import '../../data_model/data_message_model.dart';
class ItemMessageSenderShape extends StatelessWidget {

  ItemMessageSenderShape({Key key,  this.message, this.last=false}) : super(key: key);
  final DataMessageModel message;
  final bool last;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10, top: 20, bottom: 10,left: 100),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Padding(
                  padding: const EdgeInsets.all(11.0),
                  child:message.type=='text'? Text(
                    message.message,
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ):message.sendImageByMe?Image.file(message.message,width: 150,height: 250,fit: BoxFit.fill,):FadeInImage.assetNetwork(placeholder: cupertinoActivityIndicator, image: message.message, placeholderScale: 5,
                    width: 200,height: 250,

                   // Image.asset(circularProgressIndicator, scale: 10);
                ),
              ),),
            ),
            SizedBox(
              width: 10,
            ),
          if(last)  !message.seen? Icon(
              Icons.check_circle,
              color: Color.fromARGB(255, 35, 156, 255),
              size: 14,
            ):Text('seen')
          ]),
    );
  }
}