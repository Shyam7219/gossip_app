

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gossip_app/models/chat_user.dart';

class APIs {

  // for authentication
  static FirebaseAuth auth = FirebaseAuth.instance;
  
  // for accessing cloud firestore database
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  // to return current user 
  static User get user => auth.currentUser!;

  // for checking if user exists or not ?
  static Future<bool> userExists()async{
    return (await firestore
              .collection('users')
              .doc(user.uid)
              .get())
           .exists;
  }

  // for creating a new user
  static Future<void> createUser() async{
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    final chatUser = ChatUser(
        image: user.photoURL.toString(),
        name: user.displayName.toString(),
        createdAt: time,
        lastActive: time, 
        isOnline: false, 
        abaut: "hey , I am using Gossip!!", 
        id: user.uid, 
        pushToken: '', 
        email: user.email.toString());

       return await firestore.collection('user').doc(user.uid).set(chatUser.toJson());
  }
} 