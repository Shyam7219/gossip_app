import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gossip_app/main.dart';
import 'package:gossip_app/screens/login_screen.dart';

import '../api/apis.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class  _SplashScreenState extends State<SplashScreen> {

  // animation
  @override
  void initState(){
    super.initState();
    Future.delayed( const Duration(seconds: 3),() {

      // exit full screen
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
      
      if (APIs.auth.currentUser != null) {
        log('\nUser: ${APIs.auth.currentUser}');
          //navigate to home screen 
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
      }else{
         //navigate to login screen 
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
      }
    });
    
  }
  @override
  Widget build(BuildContext context) {

    mq = MediaQuery.of(context).size;

    return Scaffold(
      
      //body
       body: Stack(children: [

        //app logo
        Positioned(
          top: mq.height * .15,
          right: mq.width * .25 ,
          width: mq.width * .5,
          child:Image.asset("images/gossip.png")),

          Positioned(
          bottom: mq.height * .15,
          width: mq.height ,
          left: mq.width*.35,

          child:const Text('LETS DO IT ❤️',style: TextStyle(color: Color.fromARGB(255, 115, 58, 222), fontSize:20,fontWeight: FontWeight.bold),)
         
       )],
          ),
       
    );
  }
} 
