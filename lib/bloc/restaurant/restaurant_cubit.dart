import 'dart:convert';

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
    repository.getAllRestsByCity().then((response) {
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
      if (response.statusCode == 201) {
        List<Restaurant> restaurants = (json.decode(response.body) as List)
            .map((restaurant) => Restaurant.fromJson(restaurant))
            .toList();
        emit(RestaurantsLoaded(restaurants: restaurants));
      } else if (response.statusCode == 404) {
        List<Restaurant> restaurants = [];
        emit(RestaurantsLoaded(restaurants: restaurants, fav: false));
      } else {
        emit(RestaurantsLoadingError());
      }
    });
  }

  void isFav(Restaurant restaurant) {
    emit(RestaurantsLoading());
    repository.showFav().then((response) {
      if (response.statusCode == 201) {
        List<Restaurant> restaurants = (json.decode(response.body) as List)
            .map((restaurant) => Restaurant.fromJson(restaurant))
            .toList();
        if (restaurants.contains(restaurant)) {
          emit(RestaurantsLoaded(restaurants: restaurants, fav: true));
        } else {
          emit(RestaurantsLoaded(restaurants: restaurants, fav: false));
        }
      } else if (response.statusCode == 404) {
        List<Restaurant> restaurants = [];
        emit(RestaurantsLoaded(restaurants: restaurants, fav: false));
      } else {
        emit(RestaurantsLoadingError());
      }
    });
  }

  void addFav(String id) {
    var restaurants = state.restaurants;
    repository.addFav(id).then((response) {
      if (response.statusCode == 201) {
        emit(RestaurantsLoaded(restaurants: state.restaurants, fav: true));
      } else {
        emit(RestaurantsLoaded(restaurants: restaurants, fav: false));
      }
    });
  }

  void deleteFav(String id) {
    var restaurants = state.restaurants;
    repository.deleteFav(id).then((response) {
      if (response.statusCode == 201) {
        restaurants.removeWhere((element) => element.id == id);
        emit(RestaurantsLoaded(restaurants: restaurants, fav: false));
      } else {
        emit(RestaurantsLoaded(restaurants: restaurants, fav: true));
      }
    });
  }
}
