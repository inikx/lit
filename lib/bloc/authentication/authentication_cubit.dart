import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:lit/data/services/authentication/network_service.dart';
import 'package:lit/data/services/authentication/repository.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final AuthenticationRepository repository;
  AuthenticationCubit(this.repository) : super(AuthenticationInitial());

  void auth() {
    emit(AuthenticationChecking());
    repository.auth().then((response) => {
          if (response)
            {emit(AuthenticationSuccess())}
          else
            {emit(AuthenticationFailed())}
        });
  }
}
