import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../data_model/data_message_model.dart';
import '../../data_model/one_conversation_model.dart';
import '../../helpers/shared_value_helper.dart';
import '../../providers/message_provider.dart';
class ChatFooter extends StatefulWidget {
   ChatFooter({Key key, this.productId, this.id,this.isFirst, this.scrollController}) : super(key: key);
    final String productId;
    bool isFirst=false;
   final String id;
   final ScrollController scrollController;


   @override
  State<ChatFooter> createState() => _ChatFooterState();
}

class _ChatFooterState extends State<ChatFooter> {
bool haveText=false;


  @override
  Widget build(BuildContext context) {
    return Consumer<MessageProvider>(
        builder: (_, message, child) {
          return Container(
            child: Row(
              children: [

                Expanded(
                  child: Container(
                    margin:  EdgeInsets.only(
                        top: 10,
                        bottom:  MediaQuery.of(context).viewInsets.bottom,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                            child: TextField(
                              autofocus: true,
                              onChanged: (text) {
                                if (text.length > 0)
                                  haveText = true;
                                else
                                  haveText = false;
                                setState(() {

                                });
                              },

                              controller: message.chatInputController,
                              decoration: InputDecoration(
                                  hintText: 'Type message',
                                  border: InputBorder.none),
                            )),

                        SizedBox(
                          width: 10,
                        ),
                        InkWell(
                            onTap: () {
                              _handleImageSelection();
                            },
                            child: Icon(
                              Icons.camera_alt_outlined,
                              color: Color.fromARGB(255, 0, 127, 232),
                              size: 20,
                            )),
                        SizedBox(
                          width: 13,
                        ),
                        InkWell(
                            onTap: () {
                              if (haveText) _handleSendPressed(message.chatInputController.text);
                            },
                            child: Icon(
                              Icons.send,
                              color: haveText
                                  ? Color.fromARGB(255, 0, 127, 232)
                                  : Colors.grey,
                              size: 30,
                            )),
                        SizedBox(
                          width: 13,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                )
              ],
            ),
          );
        });

  }
void _handleImageSelection() async {
  final result = await ImagePicker().pickImage(
    imageQuality: 70,
    maxWidth: 1440,
    source: ImageSource.gallery,
  );

  if (result != null) {
    final bytes = await result.readAsBytes();
    final image = await decodeImageFromList(bytes);

    final message = DataMessageModel(
        userId: user_id.$,
      sendImageByMe: true,
      time: DateFormat("h:mma").format(DateTime.now()),
      seen: false,
      type: 'file',
      message: File(result.path)
    );
    Provider.of<MessageProvider>(context,listen: false).addConversation(message);
scroll();

   if(widget.isFirst) {
     await Provider.of<MessageProvider>(context, listen: false)
         .uploadImageForFirstCon((File(result.path)), widget.productId);
     widget.isFirst=false;
   }
   else  await Provider.of<MessageProvider>(context, listen: false)
       .uploadImageForSecondCon((File(result.path)), widget.id);
  }
}
Future<void> _handleSendPressed(text) async{
  final message = DataMessageModel(
      userId: user_id.$,
      time: DateFormat("h:mma").format(DateTime.now()),
      seen: false,
      type: 'text',
      message: text
  );
  Provider.of<MessageProvider>(context,listen: false).addConversation(message);
  scroll();
  if( Provider.of<MessageProvider>(context,listen: false).oneConversationModel.data.length==1) {
    Provider.of<MessageProvider>(context, listen: false).createConversation(
        message.message, widget.productId, 'text',context);
  }else Provider.of<MessageProvider>(context,listen: false).sendMessage(text,widget.id??-1);
  //if(widget.productId==null)
 // else Provider.of<MessageProvider>(context,listen: false).createConversation(chatInputController.text,widget.productId.toString(),"file");

}
scroll(){
  Timer(Duration(milliseconds: 500), () {

  widget.scrollController.jumpTo(
      widget.scrollController.position.maxScrollExtent);

});

}}
