


import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:gossip_app/api/apis.dart';
import 'package:gossip_app/screens/splash_screen.dart';
import 'package:gossip_app/widgets/chat_user_card.dart';


import 'firebase_options.dart';
import 'models/chat_user.dart';


// global object for accessing devise screen size ( media quary)
late Size mq;


void main() {

  // for fullscreen or orientation
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  WidgetsFlutterBinding.ensureInitialized(); 

  // orientation
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown])
      .then((value) {
      initializeFirebase();
  runApp(const MyApp());
      });
  
}

class MyApp extends StatelessWidget {
  
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gossip',                                   // its shows this title when app in recent or background
      theme: ThemeData(                    
        appBarTheme: const AppBarTheme(                 // this is costom theme it used by default at every screen
           centerTitle: true,
           elevation: 2,
           iconTheme:IconThemeData(color: Colors.black),
           titleTextStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 19),
           backgroundColor: Colors.white,),
      ),
       home: SplashScreen(),
      ); 
  }
}


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

 initializeFirebase() async {
  await Firebase.initializeApp( options: DefaultFirebaseOptions.currentPlatform,
);

}




//_______________________HomeScreen_____________________________






class _HomeScreenState extends State<HomeScreen> {

   List<ChatUser> list = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //app bar
      appBar: AppBar(
        leading: Icon(CupertinoIcons.home),
        title: const Text('Gossip'),
        actions: [
          //search user button
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),

          // more feature button
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
        ],
      ),

      // floating action button to add new/more users
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child:
         FloatingActionButton(onPressed: (){
          signOut();
         
        }, 
        child:const Icon(Icons.add_comment_rounded),),
      ),

      body: StreamBuilder(

        stream: APIs.firestore.collection('users').snapshots(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            // if data is loading
            case ConnectionState.waiting:
            case ConnectionState.none:
                return const Center(child: CircularProgressIndicator(),);

            // if some or all data is loaded then show it
            case ConnectionState.active:
            case ConnectionState.done:
              

 
         
        
            final data = snapshot.data?.docs;

            list = data?.map((e) => ChatUser.fromJson(e.data())).toList() ?? [];
          

          if(list.isNotEmpty){
            return ListView.builder(
          itemCount: list.length ,
          padding: EdgeInsets.only(top: mq.height * .01),
          physics: BouncingScrollPhysics(),
          itemBuilder:(context,index){
            return ChatUserCard(user: list[index]);
        });             
          }else {
            return Center(
              child: const Text('no connections found',
                  style: TextStyle(fontSize: 20),),
            );
          }
          }
        },
      ),
    );
      
  }
}

Future<void> signOut() async {
  await FirebaseAuth.instance.signOut();
  await GoogleSignIn().signOut();
}

