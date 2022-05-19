import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lit/bloc/restaurant/restaurant_cubit.dart';
import 'package:lit/data/models/restaurant.dart';
import 'package:lit/presentation/widgets/restaurant/restaurants_list.dart';
import 'package:progress_indicators/progress_indicators.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  void initState() {
    BlocProvider.of<RestaurantCubit>(context).showFav();
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
            "Избранное",
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  //TODO: fix
                  child: BlocBuilder<RestaurantCubit, RestaurantState>(
                    builder: (context, state) {
                      log(state.runtimeType.toString());
                      if (state is RestaurantsLoaded) {
                        var restaurants = state.restaurants;
                        List<Restaurant> allRestaurants = [];
                        for (var restaurant in restaurants) {
                          allRestaurants.add(restaurant);
                        }
                        return RestaurantsList(restaurants: allRestaurants);
                      } else if (state is RestaurantsLoading) {
                        return Center(
                            child: JumpingDotsProgressIndicator(
                          dotSpacing: 8,
                          fontSize: 80.0,
                        ));
                      } else {
                        return Center(
                            child:
                                Text("Ошибка загрузки избранных ресторанов"));
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
