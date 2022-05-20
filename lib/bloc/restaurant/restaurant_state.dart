part of 'restaurant_cubit.dart';

@immutable
abstract class RestaurantState {
  late List<Restaurant> restaurants;
  late bool? fav;
}

class RestaurantInitial extends RestaurantState {}

class RestaurantsLoading extends RestaurantState {}

class RestaurantsLoaded extends RestaurantState {
  final List<Restaurant> restaurants;
  final bool? fav;

  RestaurantsLoaded({required this.restaurants, this.fav});
}

class RestaurantAdded extends RestaurantState {
  final List<Restaurant> restaurants;
  final bool? fav;

  RestaurantAdded({required this.restaurants, this.fav});
}

class RestaurantsLoadingError extends RestaurantState {}
