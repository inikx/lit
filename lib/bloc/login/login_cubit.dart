import 'package:bloc/bloc.dart';
import 'package:lit/data/models/login.dart';
import 'package:lit/data/services/login/repository.dart';

part 'login_state.dart';

class LogInCubit extends Cubit<LogInState> {
  final LoginRepository repository;
  LogInCubit(this.repository) : super(LogInInitial(data: LogInData()));

  void updateUsername(String username) {
    final currentState = state;
    if (currentState is LogInChanged || currentState is LogInInitial) {
      emit(LogInChanged(data: currentState.data.copyWith(username: username)));
    }
  }

  void updatePassword(String password) {
    final currentState = state;
    if (currentState is LogInChanged || currentState is LogInInitial) {
      emit(LogInChanged(data: currentState.data.copyWith(password: password)));
    }
  }

  void loginUser(LogInData data) {
    final currentState = state;
    repository.loginUser(data.username, data.password).then((response) => {
          if (response.statusCode == 200 || response.statusCode == 201)
            {emit(LoggedIn())}
          else if (response.statusCode == 400)
            {emit(LogInError(data: currentState.data))}
        });
  }

  void okWithError() {
    final currentState = state;
    emit(LogInChanged(data: currentState.data));
  }
}
