import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:lit/data/models/user.dart';
import 'package:lit/data/services/user/repository.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository repository;
  UserCubit(this.repository) : super(UserInitial());

  void showUser() {
    emit(UserLoading());
    repository.showUser().then((response) {
      if (response.statusCode == 200) {
        User user = User.fromJson(json.decode(response.body));
        emit(UserLoaded(user: user));
      } else {
        emit(UserLoadingError());
      }
    });
  }

  void updateCity(User user) {
    var currentUser = user;
    repository.updateCity(currentUser.city).then((response) {
      if (response.statusCode == 200) {
        if (state is UserLoaded || state is UserCityUpdated) {
          currentUser = currentUser;
          emit(UserCityUpdated(user: currentUser));
        }
      } else {
        emit(UserLoadingError());
      }
    });
  }
}
