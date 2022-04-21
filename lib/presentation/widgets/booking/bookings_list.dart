import 'package:flutter/material.dart';

class BookingsList extends StatelessWidget {
  const BookingsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = ScrollController();

    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        controller: controller,
        child: Column(children: []));
  }
}
