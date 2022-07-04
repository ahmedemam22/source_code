import 'dart:convert';
import 'dart:io';
import 'package:active_ecommerce_flutter/providers/message_provider.dart';
import 'package:active_ecommerce_flutter/ui_elements/chat_elements/chat_body.dart';
import 'package:active_ecommerce_flutter/ui_elements/chat_elements/chat_footer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../helpers/shared_value_helper.dart';
import 'package:pusher_websocket_flutter/pusher.dart';

import '../services/pusher.dart';

class MessageScreen extends StatefulWidget {
  final String shopName;
  final String productId;
   final dynamic shopImage;
   final String shopId;
   int conversationtId;
   MessageScreen({Key key, this.shopName,this.conversationtId, this.shopImage, this.shopId, this.productId}) : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {

  List<types.Message> _messages = [];
  final _user =  types.User(id: user_id.$.toString());

  @override
  void initState() {
    super.initState();
  }
  @protected
  @mustCallSuper
  void didChangeDependencies() {
    print(widget.conversationtId);
    print('iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii');
    print(widget.productId);
  if(widget.conversationtId!=null)  PusherCreating().initPusher(widget.conversationtId,context);

    _loadMessages();


  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleAtachmentPressed() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return
          SafeArea(
            child:
            SizedBox(
              height: 144,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _handleImageSelection();
                    },
                    child: const Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text('Photo'),
                    ),
                  ),
                 /* TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _handleFileSelection();
                    },
                    child: const Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text('File'),
                    ),
                  ),*/
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text('Cancel'),
                    ),
                  ),
                ],
              ),
            ),
          );

      },
    );
  }

  void _handleFileSelection() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null && result.files.single.path != null) {
      final message = types.FileMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        mimeType: lookupMimeType(result.files.single.path),
        name: result.files.single.name,
        size: result.files.single.size,
        uri: result.files.single.path,
      );

      _addMessage(message);
    }
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

      final message = types.ImageMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        height: image.height.toDouble(),
        id: const Uuid().v4(),
        name: result.name,
        size: bytes.length,
        uri: result.path,
        width: image.width.toDouble(),
      );


      _addMessage(message);

      //await Provider.of<MessageProvider>(context,listen: false).uploadImage((File(result.path)));

    }
  }

  void _handleMessageTap(BuildContext context, types.Message message) async {
    if (message is types.FileMessage) {
      await OpenFile.open(message.uri);
    }
  }

  void _handlePreviewDataFetched(
      types.TextMessage message,
      types.PreviewData previewData,
      ) {
    final index = _messages.indexWhere((element) => element.id == message.id);
    final updatedMessage = _messages[index].copyWith();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _messages[index] = updatedMessage;
      });
    });
  }

  Future<void> _handleSendPressed(types.PartialText message) async{
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );
    _addMessage(textMessage);
    /*if(widget.productId==null)
    await Provider.of<MessageProvider>(context,listen: false).sendMessage(message.text);
    else Provider.of<MessageProvider>(context,listen: false).createConversation(message.text,widget.productId.toString(),"file");
*/
  }

  void _loadMessages() async {
  if(widget.conversationtId!=null) await Provider.of<MessageProvider>(context,listen: false).getOneConversation(widget.conversationtId);
  else await Provider.of<MessageProvider>(context,listen: false).findConversation(widget.shopId);
  /* final response = await rootBundle.loadString('assets/messages.json');
    final messages = (jsonDecode(response) as List)
        .map((e) => types.Message.fromJson(e as Map<String, dynamic>))
        .toList();

    setState(() {
      _messages = messages;
    });*/
  }

  @override
  Widget build(BuildContext context) {
    print("iddddddd${widget.productId}");
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
            color: Colors.blue
        ),


        backgroundColor: Colors.white,

        elevation: 0,
        title: Row(
          children: [
            Expanded(child: Text(widget.shopName,style:TextStyle(color: Colors.blue,overflow: TextOverflow.ellipsis))),
          ],
        ),
      ),
      body:Consumer<MessageProvider>(
      builder: (_, message, child) {
    return message.oneConversationLoading||message.findConversationLoading?Center(child:CircularProgressIndicator(),):  SafeArea(
        child: Container(
          color: Colors.grey.withOpacity(0.00),
          child: Column(
            children: [
              Expanded(
                child: ChatBody(shopImage: widget.shopImage,conversationId: widget.conversationtId??-1,),
              ),
              ChatFooter(productId:widget.productId,isFirst:message.findConversationModel.conversations!=null,id: widget.conversationtId.toString()??message.conversationModel.conversationId.toString(),),
            ],
          ),
        ));})
    );
  }
}