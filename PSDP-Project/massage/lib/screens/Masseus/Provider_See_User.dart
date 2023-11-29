import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:massage/screens/BookingScreen.dart';
// import 'package:massage/screens/Homes/home_screen.dart';
import 'package:massage/screens/Masseus/MasseusDetail.dart';
import 'package:massage/screens/Masseus/MasseusEdit.dart';
import 'package:massage/screens/Masseus/Provider_Booking.dart';
import 'package:massage/screens/Navigators/provider_navigation_bar.dart';
import 'package:massage/screens/NotificationScreen.dart';
import 'package:massage/screens/Account/UserScreen.dart';
import 'package:http/http.dart' as http;
import 'package:massage/globals.dart' as globals;

class CustomerList extends StatefulWidget {
  final int userID;

  const CustomerList({required this.userID});

  @override
  State<CustomerList> createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  // int provider = 0;
  @override
  void initState() {
    super.initState();
    getUser();
    puttoPay();
    putStatus();
  }

  Map<String, dynamic> jsonMap = {};
  @override
  Future<void> getUser() async {
    final response = await http.get(
      Uri.parse('http://localhost:3000/work_finish/${widget.userID}'),
      headers: {'Content-Type': 'application/json'},
    );
    setState(() {
      jsonMap = json.decode(response.body);
    });

    print(jsonMap);
  }

  @override
  Future<void> puttoPay() async {
    final response = await http.put(
      Uri.parse(
          'http://localhost:3000/work_finish_provider/${globals.user_id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'status': 'online',
        'customer': 'null',
        'id': globals.user_id,
      }),
    );
  }

  @override
  Future<void> putStatus() async {
    final response = await http.put(
      Uri.parse('http://localhost:3000/work_finish_user/${widget.userID}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'pay': null,
        'id': globals.user_id,
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Color.fromARGB(255, 2, 102, 74),
      ),
      backgroundColor: Color.fromARGB(255, 0, 168, 120),
      body: SafeArea(
          // child: Center(
          child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                child: SizedBox(height: 5),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 150.0,
                    )
                  ],
                ),
              ),
              Container(
                child: Text(
                  jsonMap['data']?[0]?['name'] ?? '',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                child: SizedBox(height: 10),
              ),
              Container(
                child: SizedBox(height: 20),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      jsonMap['data']?[0]?['name'] ?? '',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      jsonMap['data']?[0]?['phone'] ?? '',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      jsonMap['data']?[0]?['address'] ?? '',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: SizedBox(height: 20),
              ),
              Container(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 10, 30, 0),
                    child: ElevatedButton(
                      onPressed: () {
                        puttoPay();
                        putStatus();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NavigaBarProvider()));
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(120, 50), // กำหนดขนาดของปุ่ม
                        // สามารถกำหนดพาร์ทอื่น ๆ ของปุ่มเพิ่มเติมได้ตามต้องการ
                      ),
                      child: Text(
                        "SUCCESS",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NavigaBarProvider()));
                      },
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(120, 50),
                          backgroundColor: Colors.red // กำหนดขนาดของปุ่ม
                          // สามารถกำหนดพาร์ทอื่น ๆ ของปุ่มเพิ่มเติมได้ตามต้องการ
                          ),
                      child: Text(
                        "CANCEL",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
              SizedBox(
                height: 10,
              )
            ]),
        // ),
      )),
    );
  }
}
