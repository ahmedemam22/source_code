import 'package:flutter/material.dart';

class MessageHeaderShape extends StatelessWidget {
  const MessageHeaderShape({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.red,
      child: Row(
        children: [
          IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back)),
          SizedBox(width: 5,),
          Text("Ahmed Emam")
        ],
      ),
    );
  }
}