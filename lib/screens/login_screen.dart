import 'dart:io';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gossip_app/helper/dialogs.dart';
import 'package:gossip_app/main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../api/apis.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool _isAnimate = false;

  // animation
  @override
  void initState(){
    super.initState();
    Future.delayed( const Duration(microseconds: 500),() {
      setState(() {
      _isAnimate = true;
    });

    });
    
  }

  _handleGoogleBtnClick(){

    // for showing progressbar
    Diaologs.showProgressBar(context);

    _signInWithGoogle().then((user) async {
        // for hiding progressbar
      Navigator.pop(context);

      if (user != null) {
        
      log("\nUser: ${user.user}");
      log("\nUserAdditionalInfo: ${user.additionalUserInfo}");

      if (( await APIs.userExists())) {
        Navigator.pushReplacement(context,
                     MaterialPageRoute(builder: (_) => const HomeScreen()));
      }else{
        await APIs.createUser().then((value) => {
          Navigator.pushReplacement(context,
                     MaterialPageRoute(builder: (_) => const HomeScreen()))
        });
      }

       
      }
    });

  }

  Future<UserCredential?> _signInWithGoogle() async {

 try {

  // for cheak internet connection
  await InternetAddress.lookup('google.com');

    // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  // Create a new credential 
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await APIs.auth.signInWithCredential(credential);

 } catch (e) {
   //log('\n_signInWithGoogle: $e');
    Diaologs.showSnackbar(context,'Something went wrong cheak your internet connection');
   return null;
 }
}
         

  @override
  Widget build(BuildContext context) {

    // mwdia query object foe access screen size of device
    mq = MediaQuery.of(context).size;

    return Scaffold(
       // app bar
       appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('welcome to Gossip'),
       ),
      
      //body
       body: Stack(children: [

        //app logo
        AnimatedPositioned(
          top: mq.height * .15,
          right: _isAnimate ? mq.width * .30 : -mq.width *.5,
          width: mq.width * .40,
          duration: Duration(seconds: 1),
          child:Image.asset("images/gossip.png")),


          // googlr login button
          Positioned(
          bottom: mq.height * .15,
          left: mq.width * .06,
          width: mq.height * .4,
          height: mq.height * .07,

          child:
          ElevatedButton.icon(
           style: ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(255, 92, 215, 96,) ,shape:StadiumBorder() ),

           onPressed: () {
            _handleGoogleBtnClick();
           },

           // google icon
           icon: Image.asset("images/google.png", scale:15,),
           label: Text('Signing with Google'))),
          ],
          ),
    );
  }
} 
