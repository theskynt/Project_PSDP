import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:massage/screens/Homes/user_home_screen.dart';
import 'package:massage/globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'package:massage/screens/Navigators/user_navigation_bar.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  // final _formKey = GlobalKey<FormState>();
  int provider = 0;
  @override
  void initState() {
    super.initState();
    getPay();
    putPay();
  }

  Map<String, dynamic> jsonMap = {};
  @override
  Future<void> getPay() async {
    final response = await http.get(
      Uri.parse('http://localhost:3000/scan_qr/${globals.user_id}'),
      headers: {'Content-Type': 'application/json'},
    );
    setState(() {
      jsonMap = json.decode(response.body);
    });
  }

  @override
  Future<void> putPay() async {
    final response = await http.put(
      Uri.parse('http://localhost:3000/qr_ok/${globals.user_id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'pay': 'Success',
        'id': globals.user_id,
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
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
                child: Text(
                  "BOOKING",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                child: SizedBox(height: 20),
              ),
              Container(
                child: Text(
                  "SCAN QR",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Container(
                child: SizedBox(height: 10),
              ),
              Container(
                child: Column(children: [
                  Image.asset(
                    "assets/images/QR.png",
                    width: 200,
                    fit: BoxFit.cover,
                  )
                ]),
              ),
              Container(
                child: SizedBox(height: 20),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Text(
                          'ราคา',
                          style: TextStyle(
                              fontSize: 40,
                              color: Color.fromARGB(255, 241, 168, 8)),
                        ),
                        Text(
                          jsonMap['data']?[0]?['price'] ?? '',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                          ),
                        ),
                      ],
                    ),
                    // Text(
                    //   'ค่าเดินทาง..........100',
                    //   style: TextStyle(
                    //     color: Colors.white,
                    //     fontSize: 20,
                    //   ),
                    // ),
                    // Text(
                    //   'รวมเป็นเงิน..........250 ฿',
                    //   style: TextStyle(
                    //     color: Colors.white,
                    //     fontSize: 20,
                    //   ),
                    // ),
                  ],
                ),
              ),
              Container(
                child: SizedBox(height: 20),
              ),
              Container(
                child: Text(
                  'แนบหลักฐานการชำระ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                  child: ElevatedButton.icon(
                onPressed: () {
                  // โค้ดที่จะทำงานเมื่อปุ่มถูกกด
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(120, 20),
                  backgroundColor: Color.fromARGB(255, 227, 217, 217),
                  // กำหนดขนาดของปุ่ม
                  // สามารถกำหนดพาร์ทอื่น ๆ ของปุ่มเพิ่มเติมได้ตามต้องการ
                ),
                icon: Icon(
                  Icons.upload_file,
                  color: Colors.black,
                ),
                // ไอคอนที่จะใช้
                label: Text(
                  'Upload',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ), // ข้อความบนปุ่ม
              )),
              SizedBox(
                height: 10,
              ),
              Container(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 10, 30, 0),
                    child: ElevatedButton(
                      onPressed: () {
                        putPay();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NavigaBarUser()));
                        // โค้ดที่จะทำงานเมื่อปุ่มถูกกด
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(120, 50), // กำหนดขนาดของปุ่ม
                        // สามารถกำหนดพาร์ทอื่น ๆ ของปุ่มเพิ่มเติมได้ตามต้องการ
                      ),
                      child: Text(
                        "OK",
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
                                builder: (context) => NavigaBarUser()));
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
