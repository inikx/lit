import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lit/data/models/restaurant.dart';
import 'package:lit/presentation/widgets/restaurant/restaurant.dart';

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
