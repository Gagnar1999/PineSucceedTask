import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_project/repository/PostRepository.dart';

import '../model/Post.dart';

class HomePageProvider with ChangeNotifier {
  User? user = FirebaseAuth.instance.currentUser;
  List<Post> _posts = [];

  List<Post> get posts => _posts;
  late var repository = PostRepository();

  void getPosts() async {
    _posts = await repository.getPosts();
    notifyListeners();
  }
}
