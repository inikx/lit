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

  void showFav() {
    emit(RestaurantsLoading());
    repository.showFav().then((response) {
      if (response.statusCode == 200) {
        //log(json.decode(response.body).toString());
        //TODO:fix
        List<Restaurant> restaurants = (json.decode(response.body) as List)
            .map((restaurant) => Restaurant.fromJson(restaurant))
            .toList();
        emit(RestaurantsLoaded(restaurants: restaurants));
      } else {
        emit(RestaurantsLoadingError());
      }
    });
  }

  void addFav(String id) {
    var restaurants = state.restaurants;
    repository.addFav(id).then((response) {
      if (response.statusCode == 200) {
        List<Restaurant> restaurants = (json.decode(response.body) as List)
            .map((restaurant) => Restaurant.fromJson(restaurant))
            .toList();
        emit(RestaurantsLoaded(restaurants: restaurants));
      } else {
        //emit(RestaurantsLoadingError());
        emit(RestaurantsLoaded(restaurants: restaurants));

        //
      }
    });
  }

  void deleteFav(String id) {
    var restaurants = state.restaurants;
    repository.deleteFav(id).then((response) {
      if (response.statusCode == 200) {
        restaurants.removeWhere((element) => element.id == id);
        emit(RestaurantsLoaded(restaurants: restaurants));
      } else {
        //emit(RestaurantsLoadingError());
        emit(RestaurantsLoaded(restaurants: restaurants));
      }
    });
  }
}
