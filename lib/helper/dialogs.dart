
import 'package:flutter/material.dart';

class Diaologs {
  
  static void showSnackbar(BuildContext context, String msg){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar
    (content: Text(msg), backgroundColor: Colors.amber.withOpacity(.8),
    behavior: SnackBarBehavior.floating,));

  }

  static void showProgressBar(BuildContext context){
    showDialog(context: context, builder: (_) => const Center(child: CircularProgressIndicator()));
  }
}