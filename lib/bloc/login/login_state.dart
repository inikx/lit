part of 'login_cubit.dart';

abstract class LogInState {
  late LogInData data;
}

class LoggingIn extends LogInState {}

class LoggedIn extends LogInState {}

class LogInInitial extends LogInState {
  final LogInData data;
  LogInInitial({required this.data});
}

class LogInChanged extends LogInState {
  final LogInData data;
  LogInChanged({required this.data});
}

class LogInError extends LogInState {
  final LogInData data;
  LogInError({required this.data});
}
