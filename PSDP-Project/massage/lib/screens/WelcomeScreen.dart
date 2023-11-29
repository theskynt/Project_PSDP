import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:lottie/lottie.dart';
import 'package:massage/screens/Login_Regis/login_screen.dart';
import 'package:massage/screens/Login_Regis/register_screen.dart';
import 'package:massage/screens/Login_Regis/register_status.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 168, 120),
      body: SafeArea(
          child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 20,
            ),
            Lottie.network(
                'https://assets10.lottiefiles.com/packages/lf20_DnLK6k.json',
                height: 300,
                width: 600),
            Text(
              'TOOP TUB',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            Expanded(
              flex: 0,
              child: Text(
                'Login to your account',
                style: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                    fontWeight: FontWeight.w300,
                    // height: 1.5,
                    fontSize: 15),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  backgroundColor: Colors.purple,
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width / 3.3,
                      vertical: 20)),
              child: Text(
                'Login Now',
                style: TextStyle(fontSize: 17),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'You have\'t any account?',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.6),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                RegisterStatus()));
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                        color: Colors.purple, fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
          ],
        ),
      )),
    );
  }
}
