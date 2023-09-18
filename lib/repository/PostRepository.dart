import 'dart:convert';

import '../model/Post.dart';
import 'package:http/http.dart' as http;

class PostRepository{
  Future<List<Post>> getPosts() async{
    try{
      var response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
      if(response.statusCode == 200){
        var data = response.body;
        var list = jsonDecode(data) as List<dynamic>;
        var posts = list.map((e) => Post.fromJson(e)).toList();
        return posts;
      }
      else{
        return [];
      }
    }
    catch(e){
      return [];
    }

  }
}