import 'package:http/http.dart';
import 'package:lit/data/models/restaurant.dart';

import 'package:lit/data/services/restaurant/network_service.dart';

class RestaurantRepository {
  final RestaurantNetworkService networkService;
  RestaurantRepository(this.networkService);

  Future<Response> getAllRests() async {
    return await networkService.getAllRests();
  }
}
