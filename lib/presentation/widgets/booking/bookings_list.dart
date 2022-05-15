import 'package:flutter/material.dart';
import 'package:lit/data/models/booking.dart';
import 'package:lit/presentation/widgets/booking/booking.dart';

class BookingsList extends StatelessWidget {
  List<Booking> bookings;
  BookingsList({Key? key, required this.bookings}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = ScrollController();

    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        controller: controller,
        child: Column(children: [
          ...bookings
              .map((booking) => BookingWidget(booking: booking))
              .toList(),
        ]));
  }
}
