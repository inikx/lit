import 'package:flutter/material.dart';
import 'package:lit/presentation/widgets/booking/bookings_list.dart';

class ProfileBookingsPage extends StatelessWidget {
  const ProfileBookingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
          toolbarHeight: 48,
          title: const Text(
            "Мои бронирования",
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ),
        body: SafeArea(
          child: Column(children: [
            Expanded(
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: const BookingsList()),
            ),
          ]),
        ));
  }
}
