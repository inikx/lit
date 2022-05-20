import 'package:http/http.dart';
import 'package:lit/data/services/register/network_service.dart';

class RegisterRepository {
  final RegisterNetworkService networkService;
  RegisterRepository(this.networkService);

  Future<Response> registerUser(
      String email, String password, String city) async {
    return await networkService.register(email, password, city);
  }
}
