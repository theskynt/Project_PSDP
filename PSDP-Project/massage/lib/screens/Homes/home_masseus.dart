import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:massage/screens/BookingScreen.dart';
import 'package:massage/screens/Masseus/MasseusDetail.dart';
import 'package:massage/screens/Navigators/user_navigation_bar.dart';
import 'package:massage/screens/Search_bar.dart';
import 'package:massage/screens/Selectmasseuse/select_masseuse.dart';

class HomeMasseus extends StatefulWidget {
  const HomeMasseus({super.key});

  @override
  State<HomeMasseus> createState() => _HomemasseusState();
}

class _HomemasseusState extends State<HomeMasseus> {
  @override
  Widget build(BuildContext context) {
    return [
      Scaffold(
        appBar: AppBar(
          title: const Text('BOOKING'),
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
                  Container(
                    width: 100.0,
                    height: 100.0,
                    child: Image.asset('assets/images/massage_logo.png'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SelectMasseuse()));
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Image.asset('assets/images/1.jpg', height: 150.0),
                        SizedBox(width: 10.0),
                        Text('นวดแผนไทย',
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SelectMasseuse()));
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Image.asset('assets/images/2.jpg', height: 150.0),
                        SizedBox(width: 10.0),
                        Text('นวดน้ำมัน',
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  )
                ]),
          ),
        )),
      ),
      BookingScreen(),
    ][1];
  }
}

// Widget padded(Widget widget) {
//   return Padding(
//     padding: EdgeInsets.symmetric(horizontal: 25),
//     child: widget,
//   );

