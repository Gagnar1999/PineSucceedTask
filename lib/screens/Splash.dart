import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test_project/screens/GoogleSignIn.dart';
import 'package:test_project/screens/HomePage.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
    void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 3), (){
      var user = FirebaseAuth.instance.currentUser;
      if(user != null){
        Navigator.push(context, MaterialPageRoute(builder: (ctx)=> HomePage()));
      }else{
        Navigator.push(context, MaterialPageRoute(builder: (ctx)=> GoogleSignIn()));
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text("Google Sign in Example", style: const TextStyle(color: Colors.white, fontSize: 22),),
      ),
    );
  }
}
