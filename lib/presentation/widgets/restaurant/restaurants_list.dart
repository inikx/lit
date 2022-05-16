import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:lit/data/models/restaurant.dart';
import 'package:lit/data/models/user_location.dart';
import 'package:lit/data/providers/location_provider.dart';
import 'package:lit/data/services/location_service.dart';
import 'package:lit/presentation/pages/map.dart';
import 'package:lit/presentation/widgets/restaurant/restaurant.dart';
import 'package:provider/provider.dart';

class RestaurantsList extends StatefulWidget {
  List<Restaurant> restaurants;

  RestaurantsList({Key? key, required this.restaurants}) : super(key: key);

  @override
  State<RestaurantsList> createState() => _RestaurantsListState();
}

class _RestaurantsListState extends State<RestaurantsList> {
  final Scontroller = ScrollController();
  final Tcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          controller: Scontroller,
          child: Column(children: [
            ...widget.restaurants
                .map((restaurant) => RestaurantWidget(restaurant: restaurant))
                .toList(),
          ])),
    );
  }
}
