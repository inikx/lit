import 'package:http/http.dart';
import 'package:lit/data/services/login/network_service.dart';

class LoginRepository {
  final LoginNetworkService networkService;
  LoginRepository(this.networkService);

  Future<Response> loginUser(String username, String password) async {
    return await networkService.login(username, password);
  }
}
