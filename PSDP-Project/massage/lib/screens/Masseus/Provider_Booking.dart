import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart' as http;
import 'package:massage/globals.dart' as globals;
import 'package:massage/screens/Masseus/Provider_See_User.dart';
import 'package:massage/screens/Payment.dart';

class ProviderBooking extends StatefulWidget {
  const ProviderBooking({super.key});

  @override
  State<ProviderBooking> createState() => _ProviderBookingState();
}

class _ProviderBookingState extends State<ProviderBooking> {
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
      Uri.parse('http://localhost:3000/booking_provider/${globals.user_id}'),
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
      body: Visibility(
        // visible: isLoaded,
        child: ListView.builder(
          // itemCount: posts?.length,
          itemCount: jsonMap['data']?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.greenAccent.shade400),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width / 4,
                        vertical: 30,
                      ),
                    ),
                  ),
                  onPressed: () {
                    // getBooking();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CustomerList(
                                  userID: jsonMap['data']?[index]?['id'],
                                )));
                  },
                  child: Column(children: [
                    Text(
                      jsonMap['data']?[index]?['name'] ?? '',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    SizedBox(height: 20),
                    Column(
                      children: [
                        Text(
                          'เบอร์โทร',
                          style: TextStyle(
                              fontSize: 25,
                              color: Color.fromARGB(255, 221, 70, 10)),
                        ),
                        Text(
                          jsonMap['data']?[index]?['phone'] ?? '',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Column(
                      children: [
                        Text(
                          'ที่อยู่',
                          style: TextStyle(
                              fontSize: 25,
                              color: Color.fromARGB(255, 221, 70, 10)),
                        ),
                        Text(
                          jsonMap['data']?[index]?['address'] ?? '',
                          style: TextStyle(fontSize: 20, color: Colors.white),
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
    );
  }
}
