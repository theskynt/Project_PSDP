import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ButtonMasseus extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget screens;

  const ButtonMasseus(this.icon, this.title, this.screens);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) => screens));
      },
      icon: Icon(icon),
      label: Text(
        title,
        style: TextStyle(color: Colors.black, fontSize: 20),
      ),
      style: TextButton.styleFrom(
        minimumSize: Size.zero,
        padding: EdgeInsets.zero,
        iconColor: Colors.black,
      ),
    );
  }
}
