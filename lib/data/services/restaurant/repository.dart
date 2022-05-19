import 'package:http/http.dart';
import 'package:lit/data/models/restaurant.dart';

import 'package:lit/data/services/restaurant/network_service.dart';

class RestaurantRepository {
  final RestaurantNetworkService networkService;
  RestaurantRepository(this.networkService);

  Future<Response> getAllRests() async {
    return await networkService.getAllRests();
  }

  Future<Response> showFav() async {
    return await networkService.showFav();
  }

  Future<Response> addFav(String rest_id) async {
    return await networkService.addFav(rest_id);
  }

  Future<Response> deleteFav(String rest_id) async {
    return await networkService.deleteFav(rest_id);
  }
}
