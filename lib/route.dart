import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lit/bloc/authentication/authentication_cubit.dart';
import 'package:lit/bloc/login/login_cubit.dart';
import 'package:lit/bloc/register/register_cubit.dart';
import 'package:lit/constants/locator.dart';
import 'package:lit/constants/strings.dart';
import 'package:lit/data/provider/location_provider.dart';
import 'package:lit/data/services/authentication/network_service.dart';
import 'package:lit/data/services/authentication/repository.dart';
import 'package:lit/data/services/login/network_service.dart';
import 'package:lit/data/services/login/repository.dart';
import 'package:lit/data/services/register/network_service.dart';
import 'package:lit/data/services/register/repository.dart';
import 'package:lit/presentation/pages/authentication.dart';
import 'package:lit/presentation/pages/home.dart';
import 'package:lit/presentation/pages/login.dart';
import 'package:lit/presentation/pages/profile.dart';
import 'package:lit/presentation/pages/registration.dart';
import 'package:lit/presentation/pages/restaurants.dart';
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
        return CupertinoPageRoute(
          builder: (_) => ChangeNotifierProvider(
              create: (context) => LocationProvider(), child: HomePage()),
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
    }
  }
}
