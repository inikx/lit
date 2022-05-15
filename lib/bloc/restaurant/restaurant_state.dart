part of 'restaurant_cubit.dart';

@immutable
abstract class RestaurantState {
  late List<Restaurant> restaurants;
}

class RestaurantInitial extends RestaurantState {}

class RestaurantsLoading extends RestaurantState {}

class RestaurantsLoaded extends RestaurantState {
  final List<Restaurant> restaurants;

  RestaurantsLoaded({required this.restaurants});
}

class RestaurantsLoadingError extends RestaurantState {}
