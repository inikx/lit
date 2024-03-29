import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lit/bloc/authentication/authentication_cubit.dart';
import 'package:lit/bloc/booking/booking_cubit.dart';
import 'package:lit/bloc/login/login_cubit.dart';
import 'package:lit/bloc/register/register_cubit.dart';
import 'package:lit/bloc/restaurant/restaurant_cubit.dart';
import 'package:lit/bloc/set_booking/set_booking_cubit.dart';
import 'package:lit/bloc/user/user_cubit.dart';
import 'package:lit/constants/locator.dart';
import 'package:lit/constants/strings.dart';
import 'package:lit/data/models/booking.dart';
import 'package:lit/data/models/restaurant.dart';
import 'package:lit/data/services/authentication/repository.dart';
import 'package:lit/data/services/booking/repository.dart';
import 'package:lit/data/services/login/repository.dart';
import 'package:lit/data/services/register/repository.dart';
import 'package:lit/data/services/restaurant/repository.dart';
import 'package:lit/data/services/user/repository.dart';
import 'package:lit/presentation/pages/authentication.dart';
import 'package:lit/presentation/pages/booking_status.dart';
import 'package:lit/presentation/pages/bookings.dart';
import 'package:lit/presentation/pages/favorites.dart';
import 'package:lit/presentation/pages/home.dart';
import 'package:lit/presentation/pages/login.dart';
import 'package:lit/presentation/pages/profile.dart';
import 'package:lit/presentation/pages/registration.dart';
import 'package:lit/presentation/pages/restaurant_details.dart';
import 'package:lit/presentation/pages/user_data.dart';
import 'package:provider/provider.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AUTH:
        return CupertinoPageRoute(
          builder: (_) => BlocProvider(
            create: (context) =>
                AuthenticationCubit(getIt<AuthenticationRepository>())..auth(),
            child: AuthenticationPage(),
          ),
        );
      case LOGIN:
        return CupertinoPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => LogInCubit(getIt<LoginRepository>()),
            child: const LoginPage(),
          ),
        );
      case HOME:
        if (getIt.isRegistered<RestaurantCubit>()) {
          getIt.unregister<RestaurantCubit>();
        }
        getIt.registerSingleton(RestaurantCubit(getIt<RestaurantRepository>()));
        return CupertinoPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<RestaurantCubit>(),
            child: const HomePage(),
          ),
        );
      case REGISTER:
        return CupertinoPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => RegisterCubit(getIt<RegisterRepository>()),
            child: const RegistrationPage(),
          ),
        );
      case PROFILE:
        return CupertinoPageRoute(
          builder: (_) => const ProfilePage(),
        );
      case RESTAURANT_DETAILS:
        final args = settings.arguments as RestarauntDetailsArguments;
        if (getIt.isRegistered<RestaurantCubit>()) {
          getIt.unregister<RestaurantCubit>();
        }
        getIt.registerSingleton(RestaurantCubit(getIt<RestaurantRepository>()));
        return CupertinoPageRoute(
            builder: (_) => MultiProvider(
                  providers: [
                    BlocProvider(
                      create: (context) =>
                          BookingCubit(getIt<BookingRepository>()),
                    ),
                    BlocProvider(create: (context) => getIt<RestaurantCubit>())
                  ],
                  child: RestarauntDetails(
                    restaurant: Restaurant(
                        id: args.id,
                        title: args.title,
                        city: args.city,
                        kitchen: args.kitchen,
                        address: args.address,
                        rating: args.rating,
                        imagePath: args.imagePath,
                        averagePrice: args.averagePrice,
                        shortDescription: args.shortDescription,
                        workingHours: args.workingHours,
                        phone: args.phone),
                  ),
                ));
      case FAVORITES:
        if (getIt.isRegistered<RestaurantCubit>()) {
          getIt.unregister<RestaurantCubit>();
        }
        getIt.registerSingleton(RestaurantCubit(getIt<RestaurantRepository>()));
        return CupertinoPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<RestaurantCubit>(),
            child: const FavoritesPage(),
          ),
        );
      case BOOKING_STATUS:
        final args = settings.arguments as BookingStatusArguments;
        if (getIt.isRegistered<SetBookingCubit>()) {
          getIt.unregister<SetBookingCubit>();
        }
        getIt.registerSingleton(
            SetBookingCubit(getIt<BookingRepository>(), getIt<BookingCubit>()));
        if (getIt.isRegistered<BookingCubit>()) {
          getIt.unregister<BookingCubit>();
        }
        getIt.registerSingleton(BookingCubit(getIt<BookingRepository>()));
        return CupertinoPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => getIt<BookingCubit>(),
                  child: BookingStatusPage(
                    booking: args.booking,
                    fromList: args.fromList,
                  ),
                ));
      case BOOKINGS:
        return CupertinoPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => BookingCubit(getIt<BookingRepository>()),
                  child: BookingsPage(),
                ));

      case USER_DATA:
        if (getIt.isRegistered<UserCubit>()) {
          getIt.unregister<UserCubit>();
        }
        getIt.registerSingleton(UserCubit(getIt<UserRepository>()));
        return CupertinoPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<UserCubit>(),
            child: const UserDataPage(),
          ),
        );
    }
  }
}

class RestarauntDetailsArguments {
  String id;
  String title;
  String city;
  List<String> kitchen;
  String address;
  double rating;
  List<String> imagePath;
  int averagePrice;
  String shortDescription;
  String workingHours;
  String phone;

  RestarauntDetailsArguments(
      this.id,
      this.title,
      this.city,
      this.kitchen,
      this.address,
      this.rating,
      this.imagePath,
      this.averagePrice,
      this.shortDescription,
      this.workingHours,
      this.phone);
}

class BookingStatusArguments {
  final Booking booking;
  final bool fromList;

  BookingStatusArguments(this.booking, this.fromList);
}
