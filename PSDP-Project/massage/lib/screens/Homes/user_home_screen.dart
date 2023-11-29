import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:massage/screens/BookingScreen.dart';
import 'package:massage/screens/Masseus/MasseusDetail.dart';
import 'package:massage/screens/Navigators/user_navigation_bar.dart';
import 'package:massage/screens/NotificationScreen.dart';
import 'package:massage/screens/Search_bar.dart';
import 'package:massage/screens/Selectmasseuse/select_masseuse.dart';
import 'package:massage/screens/Account/UserScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int page = 0;

  // setPage(pg) {
  //   setState(() {
  //     page = pg;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00A878),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 150.0,
                height: 150.0,
                child: Image.asset('assets/images/massage_logo.png'),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: SearchBar(),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SelectMasseuse()),
                  );
                  // setPage(1);
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Image.asset('assets/images/1.jpg', height: 150.0),
                    SizedBox(width: 10.0),
                    Text('นวดแผนไทย',
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SelectMasseuse()),
                  );
                  // setPage(1);
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Image.asset('assets/images/2.jpg', height: 150.0),
                    SizedBox(width: 10.0),
                    Text('นวดน้ำมัน',
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
    //   SelectMasseuse(),
    // ][page];
  }
}

Widget padded(Widget widget) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 25),
    child: widget,
  );
}
