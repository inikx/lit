import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lit/bloc/restaurant/restaurant_cubit.dart';
import 'package:lit/data/models/restaurant.dart';
import 'package:lit/data/providers/location_provider.dart';
import 'package:lit/data/providers/filters_provider.dart';
import 'package:lit/presentation/pages/map.dart';
import 'package:lit/presentation/pages/profile.dart';
import 'package:lit/presentation/widgets/bottom_sheets/restaurants_filters_bottom_sheet.dart';
import 'package:lit/presentation/widgets/restaurant/restaurants_list.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class RestaurantsPage extends StatefulWidget {
  const RestaurantsPage({Key? key}) : super(key: key);

  @override
  State<RestaurantsPage> createState() => _RestaurantsPageState();
}

class _RestaurantsPageState extends State<RestaurantsPage> {
  final Tcontroller = TextEditingController();
  String query = "";

  @override
  void initState() {
    BlocProvider.of<RestaurantCubit>(context).fetchRestaurants();
    super.initState();
  }

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
              'Рестораны',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            actions: <Widget>[
              IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  icon: const Icon(Icons.filter_list, size: 26),
                  onPressed: () {
                    ProjectFiltersBottomSheet(context);
                  }),
            ]),
        body: SafeArea(
            child: Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: TextField(
                controller: Tcontroller,
                onChanged: (value) {
                  setState(() {
                    query = value;
                  });
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
          Expanded(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: BlocBuilder<RestaurantCubit, RestaurantState>(
                builder: (context, state) {
                  if (state is RestaurantsLoaded) {
                    var restaurants = state.restaurants;
                    List<Restaurant> allRestaurants = [];
                    List kitchen =
                        context.watch<FiltersProvider>().selectedKitchens;
                    double rating = context.watch<FiltersProvider>().rating;
                    int lowPrice = context.watch<FiltersProvider>().lowPrice;
                    int maxPrice = context.watch<FiltersProvider>().maxPrice;
                    String sort = context.watch<FiltersProvider>().sort;
                    if (query != "") {
                      restaurants = restaurants
                          .where((restaurant) => restaurant.title
                              .toLowerCase()
                              .contains(query.toLowerCase()))
                          .toList();
                    }
                    if (kitchen.isNotEmpty) {
                      restaurants = restaurants.where((restaurant) {
                        return restaurant.kitchen
                            .any((element) => kitchen.contains(element));
                      }).toList();
                    }
                    if (rating > 1) {
                      restaurants = restaurants.where((restaurant) {
                        return restaurant.rating >= rating;
                      }).toList();
                    }
                    if (lowPrice > 0) {
                      restaurants = restaurants.where((restaurant) {
                        return restaurant.averagePrice >= lowPrice;
                      }).toList();
                    }
                    if (maxPrice < 3000) {
                      restaurants = restaurants.where((restaurant) {
                        return restaurant.averagePrice <= maxPrice;
                      }).toList();
                    }
                    if (sort != "Рекомендованные") {
                      if (sort == "Ближайшие") {
                        //TODO: geoposition
                      } else if (sort == "С наибольшим рейтингом") {
                        restaurants
                            .sort((a, b) => b.rating.compareTo(a.rating));
                      } else if (sort == "Недорогие") {
                        (restaurants
                              ..sort((a, b) =>
                                  a.averagePrice.compareTo(b.averagePrice)))
                            .reversed
                            .toList();
                      } else if (sort == "Дорогие") {
                        restaurants.sort(
                            (a, b) => b.averagePrice.compareTo(a.averagePrice));
                      }
                    }
                    for (var restaurant in restaurants) {
                      allRestaurants.add(restaurant);
                    }
                    if (allRestaurants.isEmpty) {
                      return Center(child: Text("Рестораны не найдены"));
                    }
                    return RestaurantsList(restaurants: allRestaurants);
                  } else if (state is RestaurantsLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return Center(child: Text("Ошибка загрузки ресторанов"));
                  }
                },
              ),
            ),
          ),
        ])));
  }
}
