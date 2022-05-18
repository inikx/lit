part of 'user_cubit.dart';

@immutable
abstract class UserState {
  late User user;
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final User user;

  UserLoaded({required this.user});
}

class UserLoadingError extends UserState {}

class UserCityUpdating extends UserState {}

class UserCityUpdated extends UserState {
  final User user;

  UserCityUpdated({required this.user});
}

class UserCityUpdatingError extends UserState {}
