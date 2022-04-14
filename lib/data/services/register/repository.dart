import 'package:http/http.dart';
import 'package:lit/data/services/register/network_service.dart';

class RegisterRepository {
  final RegisterNetworkService networkService;
  RegisterRepository(this.networkService);

  Future<Response> registerUser(
      String username, String email, String password) async {
    return await networkService.register(username, email, password);
  }
}
