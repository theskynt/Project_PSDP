// import 'dart:ffi';

// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:massage/models/post.dart';
// import 'package:http/http.dart' as http;
// import 'package:massage/services/remote_service.dart';

// class TestPage extends StatefulWidget {
//   const TestPage({super.key});

//   @override
//   State<TestPage> createState() => _TestPageState();
// }

// class _TestPageState extends State<TestPage> {
//   List<Post>? posts;
//   var isLoaded = false;

//   @override
//   void initState() {
//     super.initState();
//     getData();
//   }

//   getData() async {
//     posts = await RemoteService().getPost();
//     if (posts != null) {
//       setState(() {
//         isLoaded = true;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('POSTs'),
//         ),
//         body: Visibility(
//           visible: isLoaded,
//           child: ListView.builder(
//             itemCount: posts?.length,
//             itemBuilder: (context, index) {
//               return Container(
//                 padding: const EdgeInsets.all(16),
//                 child: Row(
//                   children: [
//                     Container(
//                       height: 50,
//                       width: 50,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(12),
//                           color: Colors.grey[300]),
//                     ),
//                     SizedBox(
//                       width: 16,
//                     ),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             posts![index].title,
//                             maxLines: 2,
//                             overflow: TextOverflow.ellipsis,
//                             style: TextStyle(
//                                 fontSize: 18, fontWeight: FontWeight.bold),
//                           ),
//                           Text(
//                             posts![index].body,
//                             maxLines: 3,
//                             overflow: TextOverflow.ellipsis,
//                             // style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//           replacement: const Center(
//             child: CircularProgressIndicator(),
//           ),
//         ));
//   }
// }
