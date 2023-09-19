import 'dart:convert';

import 'package:hive/hive.dart';

import '../model/Post.dart';
import 'package:http/http.dart' as http;

class PostRepository{
  final String POST_LIST = "posts_list";
  Future<List<Post>> getPosts() async{
    try{
      var response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
      if(response.statusCode == 200){
        var data = response.body;
        _savePostLocally(data);
        var list = jsonDecode(data) as List<dynamic>;
        var posts = list.map((e) => Post.fromJson(e)).toList();
        return posts;
      }
      else{
        return _fetchLocalPosts();
      }
    }
    catch(e){
      return _fetchLocalPosts();
    }

  }

  void _savePostLocally(String resp){
    Hive.box("api_resp").put(POST_LIST, resp);
  }

  List<Post> _fetchLocalPosts(){
    String posts =  Hive.box("api_resp").get(POST_LIST);
    var postsTempList = jsonDecode(posts) as List<dynamic>;
    List<Post> postsList = [];
    postsList = postsTempList.map((e) => Post.fromJson(e)).toList();
    return postsList;
  }
}