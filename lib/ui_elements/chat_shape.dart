import 'package:active_ecommerce_flutter/screens/message_screen.dart';
import 'package:flutter/material.dart';
class ChatShape extends StatelessWidget {
  const ChatShape({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: ()=>Navigator.push(context,
          MaterialPageRoute(builder: (context) {
            return MessageScreen(shopName: "Ahmed Emam",);
          }))
      ,
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius:30,
              backgroundImage: AssetImage(
                'assets/user_profile.jpg',

              ),
            ),
            title: Text("Ahmed Emam"),
            subtitle: Text('how are you?',
              style: TextStyle(
                  overflow: TextOverflow.ellipsis
              ),),
            trailing: Text('4:05pm'),

          ),
          Divider(thickness:1 ,)
        ],
      ),

    );
  }
}