import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart' as http;
import 'package:massage/globals.dart' as globals;
import 'package:massage/screens/Payment.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final _formKey = GlobalKey<FormState>();
  int provider = 0;
  @override
  void initState() {
    super.initState();
    getBooking();
  }

  Map<String, dynamic> jsonMap = {'data': []};
  @override
  Future<void> getBooking() async {
    final response = await http.get(
      Uri.parse('http://localhost:3000/booking_user/${globals.user_id}'),
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
        title: const Text('BOOKING'),
        backgroundColor: Color.fromARGB(255, 2, 102, 74),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 0,
              ),
              Container(
                width: double.infinity,
                height: double.maxFinite,
                child: Visibility(
                  child: ListView.builder(
                    itemCount: jsonMap['data']?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40),
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.greenAccent.shade400),
                              padding:
                                  MaterialStateProperty.all<EdgeInsetsGeometry>(
                                EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width / 7,
                                  vertical: 20,
                                ),
                              ),
                            ),
                            onPressed: () {
                              getBooking();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PaymentScreen()));
                            },
                            child: Column(children: [
                              Text(
                                jsonMap['data'][index]['name'] ?? '',
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 10),
                              Column(
                                children: [
                                  Text(
                                    'ราคา',
                                    style: TextStyle(
                                        fontSize: 25,
                                        color:
                                            Color.fromARGB(255, 221, 70, 10)),
                                  ),
                                  Text(
                                    jsonMap['data'][index]['price'] ?? '',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Column(
                                children: [
                                  Text(
                                    'รายละเอียด',
                                    style: TextStyle(
                                        fontSize: 25,
                                        color:
                                            Color.fromARGB(255, 221, 70, 10)),
                                  ),
                                  Text(
                                    jsonMap['data'][index]['detail'] ?? '',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
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
                  replacement: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
