import 'package:lit/data/services/authentication/network_service.dart';

class AuthenticationRepository {
  final AuthenticationNetworkService networkService;
  AuthenticationRepository(this.networkService);

  Future<bool> auth() async {
    return await networkService.auth();
  }
}
