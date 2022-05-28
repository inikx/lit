import 'package:flutter/material.dart';

class InfoSnackbar extends StatelessWidget {
  final String title;
  final String info;
  const InfoSnackbar({
    Key? key,
    required this.title,
    required this.info,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
          height: 65,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.blueGrey.withOpacity(0.25),
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: const Offset(0, 5),
                ),
              ],
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(8))),
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20),
                child: Icon(
                  Icons.info_outline_rounded,
                  size: 25,
                  color: Colors.orangeAccent,
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 15, 25, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                          color: Colors.orangeAccent,
                          fontSize: 13,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      info,
                      style: TextStyle(
                          color: Colors.orangeAccent,
                          fontSize: 12,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
