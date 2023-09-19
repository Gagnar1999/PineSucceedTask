import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class ProfileProvider with ChangeNotifier{
  User? _user;
   User? get user=> _user;

  void getLoggedInUser(){
    _user = FirebaseAuth.instance.currentUser;
  }
}