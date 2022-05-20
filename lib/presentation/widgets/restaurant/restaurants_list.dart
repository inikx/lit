import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:lit/bloc/restaurant/restaurant_cubit.dart';
import 'package:lit/constants/locator.dart';
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
  final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.restaurants.length,
        physics: const BouncingScrollPhysics(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        controller: _controller,
        itemBuilder: (context, index) {
          return RestaurantWidget(restaurant: widget.restaurants[index]);
        });
  }
}
