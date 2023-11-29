import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:massage/screens/Masseus/MasseusDetail.dart';

class MasseuseBuuton extends StatelessWidget {
  final Widget screens;
  final Color color;
  final IconData icon;
  final String titleName;
  final String titleCoin;
  final String titleDetail;

  const MasseuseBuuton(this.screens, this.color, this.icon, this.titleName,
      this.titleCoin, this.titleDetail);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 60,
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            children: [
              Text(
                titleName,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              Text(
                titleCoin,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              Text(
                titleDetail,
                style: TextStyle(fontSize: 18, color: Colors.white),
              )
            ],
          )
        ],
      ),
      style: ElevatedButton.styleFrom(
        primary: color,
        padding: EdgeInsets.symmetric(horizontal: 90, vertical: 30),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      onPressed: () {
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(builder: (context) => MasseusDetail()),
        //   );
      },
    );
  }
}
