import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart';
import 'package:massage/screens/BookingScreen.dart';
import 'package:massage/screens/Homes/user_home_screen.dart';
import 'package:massage/screens/Masseus/MasseusDetail.dart';
import 'package:massage/screens/NotificationScreen.dart';
import 'package:massage/screens/Selectmasseuse/look_masseus.dart';
import 'package:massage/screens/Selectmasseuse/masseuse_button.dart';
import 'package:massage/screens/Account/UserScreen.dart';
import 'package:http/http.dart' as http;

class SelectMasseuse extends StatefulWidget {
  const SelectMasseuse({Key? key}) : super(key: key);

  @override
  State<SelectMasseuse> createState() => _SelectMasseuseState();
}

class _SelectMasseuseState extends State<SelectMasseuse> {
  final _formKey = GlobalKey<FormState>();
  int provider = 0;
  @override
  void initState() {
    super.initState();
    getProvider();
  }

  Map<String, dynamic> jsonMap = {'data': []};
  @override
  Future<void> getProvider() async {
    final response = await http.get(
      Uri.parse('http://localhost:3000/select_provider'),
      headers: {'Content-Type': 'application/json'},
    );
    setState(() {
      jsonMap = json.decode(response.body);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 2, 102, 74),
        title: const Text('Select Masseuse'),
      ),
      backgroundColor: Color.fromARGB(255, 0, 168, 120),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/massage_logo.png",
                  width: 180,
                  height: 170,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 320,
                  height: double.maxFinite,
                  decoration: BoxDecoration(color: Colors.white),
                  child: ListView.builder(
                    itemCount: jsonMap['data']?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 18, 130, 150),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 100, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            onPressed: () async {
                              if (jsonMap != null &&
                                  jsonMap['data'] != null &&
                                  jsonMap['data'].isNotEmpty) {
                                final id = jsonMap['data'][index]['id'];
                                final response = await http.post(
                                  Uri.parse('http://localhost:3000/data/$id'),
                                  headers: {
                                    'Content-Type': 'application/json',
                                  },
                                  body: jsonEncode({
                                    'name': 'name',
                                    'detail': 'detail',
                                  }),
                                );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MasseusDetail(
                                          provider: jsonMap['data'][index]
                                              ['id'])),
                                );
                              }
                            },
                            child: Column(children: [
                              Text(
                                jsonMap['data'][index]['name'] ?? '',
                                style: TextStyle(
                                    fontSize: 22, color: Colors.white),
                              ),
                              SizedBox(height: 15),
                              Column(
                                children: [
                                  Text(
                                    'ราคา',
                                    style: TextStyle(
                                        fontSize: 25,
                                        color:
                                            Color.fromARGB(255, 241, 168, 8)),
                                  ),
                                  Text(
                                    jsonMap['data'][index]['price'] ?? '',
                                    style: TextStyle(
                                        fontSize: 22, color: Colors.white),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15),
                              Column(
                                children: [
                                  Text(
                                    'รายละเอียด',
                                    style: TextStyle(
                                        fontSize: 25,
                                        color:
                                            Color.fromARGB(255, 241, 168, 8)),
                                  ),
                                  Text(
                                    jsonMap['data'][index]['detail'] ?? '',
                                    style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //   BookingScreen()
  // ][1];
}
