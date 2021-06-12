import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  ActionButton({this.name, this.onTap});
  final String name;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: 300,
        color: Colors.red,
        child: Text(name),
        margin: EdgeInsets.only(bottom: 10),
      ),
    );
  }
}
