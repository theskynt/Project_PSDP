import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:massage/screens/Login_Regis/InputBox/inputbox.dart';
import 'package:massage/screens/Login_Regis/InputBox/button.dart';
import 'package:massage/screens/Login_Regis/login_screen.dart';
import 'package:http/http.dart' as http;

// enum ProductTypeEnum { Male, Female }
// enum Gender { Male, Female }

class UserRegister extends StatefulWidget {
  const UserRegister({super.key});

  @override
  State<UserRegister> createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  @override
  final _formKey = GlobalKey<FormState>();
  final _username = TextEditingController();
  final _password = TextEditingController();
  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _gender = TextEditingController();
  final _email = TextEditingController();
  final _address = TextEditingController();

  bool _isLoading = false;

  Future<void> _userRegiser() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
    }

    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/register'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'username': _username.text,
          'password': _password.text,
          'name': _name.text,
          'phone': _phone.text,
          'gender': _gender.text,
          'email': _email.text,
          'address': _address.text,
          'role': 'User'
        }),
      );
      Map<String, dynamic> jsonMap = json.decode(response.body);

      if (jsonMap['status'] == 'True') {
        print(jsonMap['status']);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Signup Success'),
              content: Text('Add Success'),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            );
          },
        );
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => LoginScreen()));
      } else {
        // print("55555" + jsonMap['status']);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Signup Failed'),
              content: Text('!!Check Your E-mail'),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            );
          },
        );
        setState(() {
          print('Login failed: ${response.body}');
          print('Email or password is incorrect');
          _isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        // _errorMessage = 'Email or password is incorrect';
        _isLoading = false;
      });
      // Something went wrong, show error message
      print('Error: $error');
    }
  }

  bool _registeringStatus = false;

  // Gender? _Gender = Gender.Male;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 168, 120),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                      width: 180,
                      height: 170,
                      "assets/images/massage_logo.png"),
                  Text(
                    'Register',
                    style: GoogleFonts.chakraPetch(
                        textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    )),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.1,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(children: [
                      InputBox('Username', 'Enter Your Username', Icons.person,
                          Colors.purple, _username),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: TextFormField(
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Empty';
                            }
                            return null;
                          },
                          controller: _password,
                          obscuringCharacter: '*',
                          obscureText: true,
                          decoration: InputDecoration(
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            prefixIcon: Icon(Icons.key, color: Colors.purple),
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Password',
                            hintText: '*********',
                            labelStyle: const TextStyle(color: Colors.purple),
                          ),
                        ),
                      ),
                      InputBox('Name', 'Enter Your Name', Icons.person,
                          Colors.purple, _name),
                      InputBox('Phone', 'Enter Your Phone number', Icons.phone,
                          Colors.purple, _phone),
                      InputBox('Gender', 'Gender', Icons.male, Colors.purple,
                          _gender),
                      // Row(
                      //   children: [
                      //     Expanded(
                      //       child: RadioListTile<Gender>(
                      //           value: Gender.Male,
                      //           groupValue: _Gender,
                      //           activeColor: Color.fromARGB(255, 197, 90, 216),
                      //           contentPadding: EdgeInsets.all(0.0),
                      //           title: Text(
                      //             'Male',
                      //             style: TextStyle(color: Colors.purple),
                      //           ),
                      //           onChanged: (Gender? val) {
                      //             setState(() {
                      //               _Gender = val!;
                      //             });
                      //           }),
                      //     ),
                      //     SizedBox(
                      //       width: 5,
                      //     ),
                      //     Expanded(
                      //       child: RadioListTile<Gender>(
                      //           value: Gender.Female,
                      //           groupValue: _Gender,
                      //           activeColor: Color.fromARGB(255, 197, 90, 216),
                      //           contentPadding: EdgeInsets.all(0.0),
                      //           // tileColor: Colors.white,
                      //           title: Text('Female',
                      //               style: TextStyle(color: Colors.purple)),
                      //           onChanged: (Gender? val) {
                      //             setState(() {
                      //               _Gender = val!;
                      //             });
                      //           }),
                      //     ),
                      //   ],
                      // ),
                      SizedBox(
                        width: 5,
                      ),
                      InputBox('E-mail', 'Enter Your E-mail', Icons.email,
                          Colors.purple, _email),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 20),
                        child: TextFormField(
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Empty';
                            }
                            return null;
                          },
                          controller: _address,
                          keyboardType: TextInputType.multiline,
                          maxLines: 4,
                          maxLength: 300,
                          decoration: const InputDecoration(
                              hintText: "Write Your Address",
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.redAccent)),
                              filled: true,
                              fillColor: Colors.white),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                ),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.blueAccent),
                                padding: MaterialStateProperty.all<
                                    EdgeInsetsGeometry>(
                                  EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.width / 10,
                                    vertical: 10,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                _userRegiser();
                              },
                              child: Text('OK'),
                            ),
                          ),
                          Expanded(
                              child: InputButton(
                                  LoginScreen(), Colors.redAccent, 'cencel'))
                        ],
                      )
                    ]),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
