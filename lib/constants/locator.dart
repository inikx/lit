import 'package:get_it/get_it.dart';
import 'package:lit/bloc/authentication/authentication_cubit.dart';
import 'package:lit/bloc/booking/booking_cubit.dart';
import 'package:lit/bloc/login/login_cubit.dart';
import 'package:lit/bloc/register/register_cubit.dart';
import 'package:lit/bloc/restaurant/restaurant_cubit.dart';
import 'package:lit/bloc/set_booking/set_booking_cubit.dart';
import 'package:lit/bloc/user/user_cubit.dart';

import 'package:lit/data/services/authentication/network_service.dart';
import 'package:lit/data/services/authentication/repository.dart';
import 'package:lit/data/services/booking/network_service.dart';
import 'package:lit/data/services/booking/repository.dart';
import 'package:lit/data/services/login/network_service.dart';
import 'package:lit/data/services/login/repository.dart';
import 'package:lit/data/services/register/network_service.dart';
import 'package:lit/data/services/register/repository.dart';
import 'package:lit/data/services/restaurant/network_service.dart';
import 'package:lit/data/services/restaurant/repository.dart';
import 'package:lit/data/services/user/network_service.dart';
import 'package:lit/data/services/user/repository.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  // LogIn
  getIt.registerSingleton(LoginNetworkService());
  getIt.registerSingleton(LoginRepository(getIt<LoginNetworkService>()));
  getIt.registerSingleton(LogInCubit(getIt<LoginRepository>()));

  // Registration
  getIt.registerSingleton(RegisterNetworkService());
  getIt.registerSingleton(RegisterRepository(getIt<RegisterNetworkService>()));
  getIt.registerSingleton(RegisterCubit(getIt<RegisterRepository>()));

  // Authentication
  getIt.registerSingleton(AuthenticationNetworkService());
  getIt.registerSingleton(
      AuthenticationRepository(getIt<AuthenticationNetworkService>()));
  getIt.registerSingleton(
      AuthenticationCubit(getIt<AuthenticationRepository>()));

  //Bookings
  getIt.registerSingleton(BookingNetworkService());
  getIt.registerSingleton(BookingRepository(getIt<BookingNetworkService>()));
  getIt.registerSingleton(BookingCubit(getIt<BookingRepository>()));

  //Set Booking
  getIt.registerSingleton(
      SetBookingCubit(getIt<BookingRepository>(), getIt<BookingCubit>()));

  //Restaurants
  getIt.registerSingleton(RestaurantNetworkService());
  getIt.registerSingleton(
      RestaurantRepository(getIt<RestaurantNetworkService>()));
  getIt.registerSingleton(RestaurantCubit(getIt<RestaurantRepository>()));

  //User
  getIt.registerSingleton(UserNetworkService());
  getIt.registerSingleton(UserRepository(getIt<UserNetworkService>()));
  getIt.registerSingleton(UserCubit(getIt<UserRepository>()));
}
