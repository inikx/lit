part of 'register_cubit.dart';

@immutable
abstract class RegisterState {
  late RegisterData data;
}

class RegisterInitial extends RegisterState {
  final RegisterData data;

  RegisterInitial({required this.data});
}

class RegisterChanged extends RegisterState {
  final RegisterData data;

  RegisterChanged({required this.data});
}

class UserRegistered extends RegisterState {}

class RegisterError extends RegisterState {
  final List<dynamic> errors;
  final RegisterData data;

  RegisterError({required this.errors, required this.data});
}
