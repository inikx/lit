import 'package:flutter/material.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';

class RestaurantsList extends StatelessWidget {
  const RestaurantsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = ScrollController();

    return SingleChildScrollView(
        controller: controller,
        child: Column(children: [
          Restaurant(title: "ГОВНО ЖОПА", rating: 2.8),
          Restaurant(title: "nazvanie", rating: 2.8),
          Restaurant(title: "nazvanie", rating: 2.8),
          Restaurant(title: "nazvanie", rating: 2.8),
          Restaurant(title: "nazvanie", rating: 2.8),
          Restaurant(title: "nazvanie", rating: 2.8),
          Restaurant(title: "nazvanie", rating: 2.8),
          Restaurant(title: "nazvanie", rating: 2.8),
          Restaurant(title: "nazvanie", rating: 2.8),
          Restaurant(title: "nazvanie", rating: 2.8),
          Restaurant(title: "nazvanie", rating: 2.8),
          Restaurant(title: "nazvanie", rating: 2.8),
          Restaurant(title: "nazvanie", rating: 2.8),
          Restaurant(title: "nazvanie", rating: 2.8),
          Restaurant(title: "nazvanie", rating: 2.8),
          Restaurant(title: "nazvanie", rating: 2.8),
          Restaurant(title: "nazvanie", rating: 2.8),
          Restaurant(title: "nazvanie", rating: 2.8),
          Restaurant(title: "nazvanie", rating: 2.8),
          Restaurant(title: "nazvanie", rating: 2.8),
          Restaurant(title: "nazvanie", rating: 2.8),
          Restaurant(title: "nazvanie", rating: 2.8),
          Restaurant(title: "nazvanie", rating: 2.8),
          Restaurant(title: "nazvanie", rating: 2.8),
          Restaurant(title: "nazvanie", rating: 2.8),
          Restaurant(title: "nazvanie", rating: 2.8),
          Restaurant(title: "nazvanie", rating: 2.8),
          Restaurant(title: "nazvanie", rating: 2.8),
          Restaurant(title: "nazvanie", rating: 2.8),
          Restaurant(title: "nazvanie", rating: 50)
        ]));
  }
}

class Restaurant extends StatelessWidget {
  final String title;
  final double rating;

  const Restaurant({Key? key, required this.title, required this.rating})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const Pad(all: 20),
      child: Container(
          color: Colors.red,
          width: MediaQuery.of(context).size.width,
          height: 135,
          child: Column(children: [Text(title), Text(rating.toString())])),
    );
  }
}
