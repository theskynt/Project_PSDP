import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:massage/screens/BookingScreen.dart';
import 'package:massage/screens/Navigators/user_navigation_bar.dart';

import 'package:massage/screens/NotificationScreen.dart';
import 'package:massage/screens/Account/UserScreen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:ffi';
import 'package:massage/globals.dart' as globals;

class MasseusDetail extends StatefulWidget {
  final int provider;

  MasseusDetail({Key? key, required this.provider}) : super(key: key);
  //const MasseusDetail({super.key});

  @override
  State<MasseusDetail> createState() => _MasseusDetailState();
}

class _MasseusDetailState extends State<MasseusDetail> {
  _MasseusDetailState();

  @override
  void initState() {
    super.initState();
    getDtail();
  }

  Map<String, dynamic> jsonMap = {};
  @override
  Future<void> getDtail() async {
    final response = await http.get(
      Uri.parse('http://localhost:3000/reserve_provider/${widget.provider}'),
      headers: {'Content-Type': 'application/json'},
    );
    setState(() {
      jsonMap = json.decode(response.body);
      print(jsonMap);
    });
  }

  @override
  Future<void> putData() async {
    final response = await http.put(
      Uri.parse('http://localhost:3000/reserve_provider_ok/${widget.provider}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'status': 'offline',
        'customer': globals.user_id,
        'id': widget.provider,
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ABOUT US'),
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
                SizedBox(
                  height: 10,
                ),
                Text(
                  jsonMap["data"]?[0]?['name'] ?? '',
                  style: TextStyle(
                      fontSize: 20, color: Color.fromARGB(255, 0, 0, 0)),
                ),
                SizedBox(
                  height: 10,
                ),
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
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 300,
                  child: ListTile(
                    title: Text(
                      'รายละเอียด',
                      style: TextStyle(fontSize: 25),
                    ),
                    subtitle: Text(
                      jsonMap["data"]?[0]?['detail'] ?? '',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 60.0,
                      ),
                      SizedBox(height: 10.0),
                      Column(children: <Widget>[
                        Text('คนรีวิว 1',
                            style:
                                TextStyle(fontSize: 18, color: Colors.white)),
                        Row(children: <Widget>[
                          Icon(Icons.star, color: Colors.yellow, size: 20.0),
                          Icon(Icons.star, color: Colors.yellow, size: 20.0),
                          Icon(Icons.star, color: Colors.yellow, size: 20.0),
                          Icon(Icons.star, color: Colors.yellow, size: 20.0),
                          Icon(Icons.star, color: Colors.grey, size: 20.0),
                        ]),
                        Text('ลายละเอียดรีวิว',
                            style:
                                TextStyle(fontSize: 14, color: Colors.white)),
                      ]),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    padding:
                        EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        putData();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    BookingScreen()));
                      },
                      // =>
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (BuildContext context) =>
                      //             BookingScreen())),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.blue),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      child: Text('RESERVE',
                          style: TextStyle(fontSize: 18, color: Colors.blue)),
                    ),
                    OutlinedButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  NavigaBarUser())),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.red),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      child: Text('CANCEL',
                          style: TextStyle(fontSize: 18, color: Colors.red)),
                    )
                  ],
                )
              ]),
        ),
      )),
    );
  }
}
