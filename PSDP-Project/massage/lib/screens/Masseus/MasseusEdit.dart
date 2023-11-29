import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:massage/screens/BookingScreen.dart';
import 'package:massage/screens/Masseus/PostDetail.dart';

import 'package:massage/screens/NotificationScreen.dart';
import 'package:massage/screens/Account/UserScreen.dart';
import 'package:massage/globals.dart' as globals;
import 'package:http/http.dart' as http;

class MasseusEdit extends StatefulWidget {
  const MasseusEdit({super.key});

  @override
  State<MasseusEdit> createState() => _MasseusEditState();
}

class _MasseusEditState extends State<MasseusEdit> {
  bool isSwitched = false;

  String selectState = 'offline';
  int provider = 0;
  @override
  void initState() {
    super.initState();
    getDetailUser();
    puttoProvider();
  }

  Map<String, dynamic> jsonMap = {};
  @override
  Future<void> getDetailUser() async {
    final response = await http.get(
      Uri.parse('http://localhost:3000/home_provider/${globals.user_id}'),
      headers: {'Content-Type': 'application/json'},
    );
    setState(() {
      jsonMap = json.decode(response.body);
    });
  }

  @override
  Future<void> puttoProvider() async {
    final response = await http.put(
      Uri.parse(
          'http://localhost:3000/post_status_provider/${globals.user_id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'status': selectState,
        'id': globals.user_id,
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DETAIL'),
        backgroundColor: Color.fromARGB(255, 2, 102, 74),
      ),
      // backgroundColor: Color.fromARGB(255, 0, 168, 120),
      body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  // padding: EdgeInsetsDirectional.fromSTEB(15, 60, 0, 0),
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://images.everydayhealth.com/images/what-to-know-before-getting-a-massage-with-ankylosing-spondylitis-1440x810.jpg',
                      ),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Container(
                  width: 200,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            "OFFLINE",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      Switch(
                        value: isSwitched,
                        onChanged: (value) {
                          setState(() {
                            isSwitched = value;
                            print(isSwitched);
                            if (value == true) {
                              print('online');
                              selectState = 'online';
                            } else {
                              print('offline');
                              selectState = 'offline';
                            }
                          });
                        },
                        activeTrackColor: Colors.lightGreenAccent,
                        activeColor: Colors.green,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            "ONLINE",
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(jsonMap['data']?[0]?['name'] ?? '',
                    style: TextStyle(fontSize: 40)),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(Icons.star, color: Colors.yellow),
                    Icon(Icons.star, color: Colors.yellow),
                    Icon(Icons.star, color: Colors.yellow),
                    Icon(Icons.star, color: Colors.grey),
                    Icon(Icons.star, color: Colors.grey),
                    Text('4.0', style: TextStyle(fontSize: 16)),
                  ],
                ),
                Container(
                  width: 400,
                  child: ListTile(
                    title: Text('รายละเอียด', style: TextStyle(fontSize: 25)),
                    subtitle: Text(
                      jsonMap['data']?[0]?['detail'] ?? '',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 400,
                  child: ListTile(
                    title: Text('ราคา', style: TextStyle(fontSize: 25)),
                    subtitle: Text(
                      jsonMap['data']?[0]?['price'] ?? '',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        puttoProvider();
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Update'),
                              content: Text('Post Success'),
                              actions: [
                                TextButton(
                                  child: Text('OK'),
                                  onPressed: () => Navigator.of(context).pop(),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.blue),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      child: Text('UPDATE',
                          style: TextStyle(fontSize: 18, color: Colors.blue)),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PostDetail()));
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.green),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      child: Text('EDIT',
                          style: TextStyle(fontSize: 18, color: Colors.green)),
                    )
                  ],
                )
              ]),
        ),
      )),
    );
  }
}
