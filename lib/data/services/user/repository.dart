import 'package:http/http.dart';

import 'package:lit/data/services/user/network_service.dart';

class UserRepository {
  final UserNetworkService networkService;
  UserRepository(this.networkService);

  Future<Response> showUser() async {
    return await networkService.showUser();
  }

  Future<Response> updateCity(String city) async {
    return await networkService.updateCity(city);
  }
}
