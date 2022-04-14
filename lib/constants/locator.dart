import 'package:get_it/get_it.dart';
import 'package:lit/bloc/authentication/authentication_cubit.dart';
import 'package:lit/bloc/login/login_cubit.dart';
import 'package:lit/bloc/register/register_cubit.dart';

import 'package:lit/data/services/authentication/network_service.dart';
import 'package:lit/data/services/authentication/repository.dart';
import 'package:lit/data/services/login/network_service.dart';
import 'package:lit/data/services/login/repository.dart';
import 'package:lit/data/services/register/network_service.dart';
import 'package:lit/data/services/register/repository.dart';

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
}
