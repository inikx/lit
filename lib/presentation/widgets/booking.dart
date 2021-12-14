import 'package:flutter/material.dart';
import 'package:lit/presentation/pages/restaurant_page.dart';

class Booking extends StatefulWidget {
  const Booking({Key? key}) : super(key: key);

  @override
  _BookingState createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.remove, color: Colors.black),
      backgroundColor: Colors.white,
      onPressed: () {
        setState(() {});
      },
    );
  }
}
