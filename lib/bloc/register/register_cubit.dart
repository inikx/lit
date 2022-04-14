import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:lit/data/models/register.dart';
import 'package:lit/data/services/register/repository.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterRepository? repository;

  RegisterCubit(this.repository) : super(RegisterInitial(data: RegisterData()));

  void updateUsername(String username) {
    final currentState = state;
    if (currentState is RegisterChanged || currentState is RegisterInitial) {
      emit(RegisterChanged(
          data: currentState.data.copyWith(username: username)));
    }
  }

  void updateEmail(String email) {
    final currentState = state;
    if (currentState is RegisterChanged || currentState is RegisterInitial) {
      emit(RegisterChanged(data: currentState.data.copyWith(email: email)));
    }
  }

  void updatePassword(String password) {
    final currentState = state;
    if (currentState is RegisterChanged || currentState is RegisterInitial) {
      emit(RegisterChanged(
          data: currentState.data.copyWith(password: password)));
    }
  }

  void registerUser(RegisterData data) {
    repository!
        .registerUser(data.username, data.email, data.password)
        .then((response) => {
              if (response.statusCode == 200 || response.statusCode == 201)
                {emit(UserRegistered())}
              else
                {
                  emit(RegisterError(
                      errors: [response.body], data: state.data.copyWith()))
                }
            });
  }

  void okWithError() {
    final currentState = state;
    emit(RegisterChanged(data: currentState.data.copyWith()));
  }
}
