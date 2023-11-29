import 'dart:convert';

// List<Post> postFromJson(String str) =>
//     List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));

// String postToJson(List<Post> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class Post {
//   int userId;
//   int id;
//   String title;
//   String body;

//   Post({
//     required this.userId,
//     required this.id,
//     required this.title,
//     required this.body,
//   });

//   factory Post.fromJson(Map<String, dynamic> json) => Post(
//         userId: json["userId"],
//         id: json["id"],
//         title: json["title"],
//         body: json["body"],
//       );

//   Map<String, dynamic> toJson() => {
//         "userId": userId,
//         "id": id,
//         "title": title,
//         "body": body,
//       };
// }

import 'dart:convert';

List<UserRegisPost> userRegisPostFromJson(String str) =>
    List<UserRegisPost>.from(
        json.decode(str).map((x) => UserRegisPost.fromJson(x)));

String userRegisPostToJson(List<UserRegisPost> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserRegisPost {
  String username;
  String password;
  String email;
  String phone;
  String name;
  String gender;
  String address;
  int id;

  UserRegisPost({
    required this.username,
    required this.password,
    required this.email,
    required this.phone,
    required this.name,
    required this.gender,
    required this.address,
    required this.id,
  });

  factory UserRegisPost.fromJson(Map<String, dynamic> json) => UserRegisPost(
        username: json["username"],
        password: json["password"],
        email: json["email"],
        phone: json["phone"],
        name: json["name"],
        gender: json["gender"],
        address: json["address"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
        "email": email,
        "phone": phone,
        "name": name,
        "gender": gender,
        "address": address,
        "id": id,
      };
}
