import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:lit/data/models/restaurant.dart';
import 'package:lit/data/services/restaurant/repository.dart';

part 'restaurant_state.dart';

class RestaurantCubit extends Cubit<RestaurantState> {
  final RestaurantRepository repository;
  RestaurantCubit(this.repository) : super(RestaurantInitial());

  void fetchRestaurants() {
    emit(RestaurantsLoading());
    repository.getAllRests().then((response) {
      if (response.statusCode == 200) {
        List<Restaurant> restaurants = (json.decode(response.body) as List)
            .map((restaurant) => Restaurant.fromJson(restaurant))
            .toList();
        emit(RestaurantsLoaded(restaurants: restaurants));
      } else {
        emit(RestaurantsLoadingError());
      }
    });
  }
}
