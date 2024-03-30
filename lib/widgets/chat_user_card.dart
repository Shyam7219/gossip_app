
import 'package:flutter/material.dart';
import 'package:gossip_app/models/chat_user.dart';

import '../main.dart';

// card to represent aa single user in home screen
class ChatUserCard extends StatefulWidget {

  final ChatUser user;
  const ChatUserCard({super.key, required this.user});

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: mq.width * .01, vertical: 4),
      //color: Colors.blue.shade100,
      elevation: 0.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: () {},
        child: ListTile(
          // user profile picture
          leading: const CircleAvatar(child: Icon(Icons.person),),

          // user name
          title:Text(widget.user.name) ,

          // last message 
          subtitle: Text(widget.user.abaut,maxLines: 1,),

          // last message time
          trailing: Text(
            '12:00 PM',style: TextStyle(color: Colors.black54),),

        ),
      ),
    );
  }
} 