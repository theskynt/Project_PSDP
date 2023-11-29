// import 'package:http/http.dart' as http;

// // Future<bool> registerUser(String name, String email, String password) async {
// //   final response = await http.post(
// //     Uri.parse('https://localhost:8000/register'),
// //     body: {
// //       'name': name,
// //       'email': email,
// //       'password': password,
// //     },
// //   );
// //   if (response.statusCode == 200) {
// //     return true;
// //   } else {
// //     return false;
// //   }
// // }

// Future<bool> registerUser(String name, String email, String password) async {
//   final response = await http.get(
//     Uri.parse('http://127.0.0.1:8000/users/'),
//     body: {
//       'name': name,
//       'email': email,
//       'password': password,
//     },
//   );
//   if (response.statusCode == 200) {
//     return true;
//   } else {
//     return false;
//   }
// }


