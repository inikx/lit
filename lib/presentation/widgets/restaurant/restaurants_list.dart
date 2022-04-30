import 'package:flutter/material.dart';
import 'package:lit/data/models/restaurant.dart';
import 'package:lit/data/models/user_location.dart';
import 'package:lit/data/providers/location_provider.dart';
import 'package:lit/data/services/location_service.dart';
import 'package:lit/presentation/widgets/restaurant/restaurant.dart';
import 'package:provider/provider.dart';

class RestaurantsList extends StatefulWidget {
  List<Restaurant> restaurants;

  RestaurantsList({Key? key, required this.restaurants}) : super(key: key);

  @override
  State<RestaurantsList> createState() => _RestaurantsListState();
}

class _RestaurantsListState extends State<RestaurantsList> {
  List<Restaurant> foundRestaurants = [];
  final Tcontroller = TextEditingController();
  final Scontroller = ScrollController();

  @override
  initState() {
    foundRestaurants = widget.restaurants;
    super.initState();
  }

  void search(String query) {
    List<Restaurant> results = [];
    if (query.isEmpty) {
      setState(() {
        results = widget.restaurants;
      });
    } else {
      results = widget.restaurants.where((restaurant) {
        return restaurant.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    setState(() {
      foundRestaurants = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        controller: Scontroller,
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: TextField(
                controller: Tcontroller,
                onChanged: (value) {
                  search(value);
                },
                textCapitalization: TextCapitalization.words,
                cursorColor: Colors.grey,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  hintText: 'Поиск',
                  hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
                  contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                )),
          ),
          ...foundRestaurants
              .map((restaurant) => RestaurantWidget(restaurant: restaurant))
              .toList(),
        ]));
  }
}
