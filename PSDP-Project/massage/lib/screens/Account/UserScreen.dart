import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:massage/screens/Items/popupbutton.dart';
import 'package:massage/screens/Login_Regis/login_screen.dart';
import 'package:massage/screens/Masseus/ButtonMasseus/button_masseus.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 168, 120),
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 170, vertical: 10),
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://images.everydayhealth.com/images/what-to-know-before-getting-a-massage-with-ankylosing-spondylitis-1440x810.jpg',
                    ),
                    fit: BoxFit.cover,
                    opacity: 0.7,
                  ),
                ),
                child: Column(
                  children: [
                    // MyPopupButton(),
                    Image.asset(
                      'assets/images/user.png',
                      fit: BoxFit.contain,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // Text(
                    //   'USER NAME',
                    //   style: TextStyle(
                    //     color: Colors.white,
                    //     fontSize: 20,
                    //   ),
                    // ),
                  ],
                ),
              ),
              Container(
                width: 300,
                height: 400,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 240,
                      height: 340,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ButtonMasseus(
                              Icons.location_on,
                              'My Address               >',
                              UserScreen(),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Underline(),
                            ButtonMasseus(
                              Icons.group,
                              'Account                     >',
                              UserScreen(),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Underline(),
                            ButtonMasseus(Icons.notifications,
                                'Notifications              >', UserScreen()),
                            SizedBox(
                              height: 20,
                            ),
                            Underline(),
                            ButtonMasseus(Icons.edit_square,
                                'Edit Profile                 >', UserScreen()),
                            SizedBox(
                              height: 20,
                            ),
                            Underline(),
                            ButtonMasseus(Icons.error,
                                'About Me                  >', UserScreen()),
                            SizedBox(
                              height: 20,
                            ),
                            Underline(),
                            ButtonMasseus(
                                Icons.logout_outlined,
                                'Logout                       >',
                                LoginScreen()),
                          ]),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Underline extends StatelessWidget {
  const Underline({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 10,
      color: Colors.grey,
      thickness: 1,
      indent: 1,
      endIndent: 1,
    );
  }
}
