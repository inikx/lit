import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AppElevatedButton extends StatelessWidget {
  final String title;
  final double fontSize;
  final double width;
  final VoidCallback onPressed;
  AppElevatedButton(
      {Key? key,
      required this.title,
      required this.onPressed,
      required this.width,
      required this.fontSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: width,
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.black),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ))),
        onPressed: onPressed,
        child: Text(title,
            style: TextStyle(
              color: Colors.white,
              fontSize: fontSize,
            )),
      ),
    );
  }
}

/* 

*/