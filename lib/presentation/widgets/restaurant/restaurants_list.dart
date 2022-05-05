import 'package:flutter/material.dart';
import 'package:lit/data/models/restaurant.dart';
import 'package:lit/data/models/user_location.dart';
import 'package:lit/data/providers/location_provider.dart';
import 'package:lit/data/services/location_service.dart';
import 'package:lit/presentation/widgets/restaurant/restaurant.dart';
import 'package:provider/provider.dart';

class RestaurantsList extends StatelessWidget {
  List<Restaurant> restaurants;

  RestaurantsList({Key? key, required this.restaurants}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Scontroller = ScrollController();
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        controller: Scontroller,
        child: Column(children: [
          ...restaurants
              .map((restaurant) => RestaurantWidget(restaurant: restaurant))
              .toList(),
        ]));
  }
}
