import 'dart:convert';

import 'package:massage/models/post.dart';
import 'package:http/http.dart' as http;

class RemoteService {
//   // Future<List<Post>?> getPost() async {
//   //   var client = http.Client();

//   //   var uri = Uri.parse('https://jsonplaceholder.typicode.com/posts');
//   //   var response = await client.get(uri);
//   //   if (response.statusCode == 200) {
//   //     var json = response.body;
//   //     return postFromJson(json);
//   //   }
//   // }

  Future<List<UserRegisPost>?> postData() async {
    var client = http.Client();

    var uri = Uri.parse('http://127.0.0.1:8000/users/');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return userRegisPostFromJson(json);
    }
  }
}
