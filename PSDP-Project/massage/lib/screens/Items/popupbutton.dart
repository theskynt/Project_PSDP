import 'package:flutter/material.dart';

class MyPopupButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
            child: Text('Option 1'),
            value: 1,
          ),
          PopupMenuItem(
            child: Text('Option 2'),
            value: 2,
          ),
          PopupMenuItem(
            child: Text('Option 3'),
            value: 3,
          ),
        ];
      },
      onSelected: (value) {
        // Handle selected value here
        print('Selected value: $value');
      },
      child: Icon(Icons.more_vert),
    );
  }
}
