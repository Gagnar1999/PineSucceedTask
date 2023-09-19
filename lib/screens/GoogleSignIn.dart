import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project/authentication/Authentication.dart';
import 'package:test_project/screens/HomePage.dart';

class GoogleSignIn extends StatefulWidget {
  const GoogleSignIn({super.key});

  @override
  State<GoogleSignIn> createState() => _GoogleSignInState();
}

class _GoogleSignInState extends State<GoogleSignIn> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 150,
              child: Center(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(backgroundColor: Colors.white),
                  onPressed: singInWithGoogle,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        "assets/images/gicon.png",
                        height: 30,
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        "Sign in With Google",
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void singInWithGoogle() async{
   // await Authentication.logout(context: context);
   var user = await Authentication.signInWithGoogle(context: context);
   if(user!= null){
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=> HomePage()));
   }
   else{
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("There is Some Error")));
   }
  }
}
