//import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:massage/screens/Masseus/MasseusEdit.dart';
import 'package:massage/screens/Masseus/Provider_Booking.dart';
import 'package:massage/screens/NotificationScreen.dart';
import 'package:massage/screens/Account/UserScreen.dart';

class NavigaBarProvider extends StatefulWidget {
  const NavigaBarProvider({super.key});

  @override
  State<NavigaBarProvider> createState() => _NavigaBarProviderState();
}

class _NavigaBarProviderState extends State<NavigaBarProvider> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    const MasseusEdit(),
    const ProviderBooking(),
    const NotificationScreen(),
    const UserScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            label: 'Booking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notification',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Me',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(255, 254, 94, 65),
        unselectedItemColor: Color.fromARGB(255, 0, 168, 120),
        onTap: _onItemTapped,
      ),
    );
  }
}
