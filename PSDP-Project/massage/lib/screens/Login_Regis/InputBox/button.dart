import 'package:flutter/material.dart';

class InputButton extends StatelessWidget {
  final Widget screens;
  final Color color;
  final String title;

  const InputButton(this.screens, this.color, this.title);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(color),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 10,
            vertical: 10,
          ),
        ),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screens),
        );
      },
      child: Text(title),
    );
  }
}
