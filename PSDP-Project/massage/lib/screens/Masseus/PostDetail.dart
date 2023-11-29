import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:massage/globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'package:massage/screens/Masseus/MasseusEdit.dart';
import 'package:massage/screens/Navigators/provider_navigation_bar.dart';

class PostDetail extends StatefulWidget {
  const PostDetail({super.key});

  @override
  State<PostDetail> createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final _price = TextEditingController();
  final _detail = TextEditingController();

  @override
  void initState() {
    super.initState();
    getNameProvider();
    putProviderEdit();
  }

  Map<String, dynamic> jsonMap = {};
  @override
  Future<void> getNameProvider() async {
    final response = await http.get(
      Uri.parse('http://localhost:3000/home_provider_edit/${globals.user_id}'),
      headers: {'Content-Type': 'application/json'},
    );
    setState(() {
      jsonMap = json.decode(response.body);
    });
  }

  @override
  Future<void> putProviderEdit() async {
    final response = await http.put(
      Uri.parse('http://localhost:3000/edit_post_provider/${globals.user_id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'price': _price.text,
        'detail': _detail.text,
        'id': globals.user_id,
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 2, 102, 74),
          title: Text(
            'PostDetail',
          )),
      backgroundColor: Color.fromARGB(255, 0, 168, 120),
      body: SafeArea(
          child: Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    jsonMap['data']?[0]?['name'] ?? '',
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      width: 320,
                      height: double.maxFinite,
                      decoration: BoxDecoration(color: Colors.white),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              '   Add course',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          TextFormField(
                            controller: _detail,
                            keyboardType: TextInputType.multiline,
                            maxLines: 4,
                            maxLength: 200,
                            decoration: const InputDecoration(
                                hintText: "คำอธิบายคอร์ส",
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.white)),
                                filled: true,
                                fillColor: Colors.white),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: _price,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 3, color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 3, color: Colors.black),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 3,
                                    color: Color.fromARGB(255, 66, 125, 145)),
                              ),
                              labelText: "Total Price:",
                              filled: true,
                              fillColor: Colors.white,
                              labelStyle: TextStyle(color: Colors.black),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              putProviderEdit();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          NavigaBarProvider()));
                            },
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(120, 50),
                              backgroundColor: Colors.lightBlue,
                              // กำหนดขนาดของปุ่ม
                              // สามารถกำหนดพาร์ทอื่น ๆ ของปุ่มเพิ่มเติมได้ตามต้องการ
                            ),
                            icon: Icon(
                              Icons.edit,
                              color: Colors.black,
                            ),
                            // ไอคอนที่จะใช้
                            label: Text(
                              'Edit',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ), // ข้อความบนปุ่ม
                          )
                        ],
                      )),
                ]),
          ),
        ),
      )),
    );
  }
}
