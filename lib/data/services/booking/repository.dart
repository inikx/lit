import 'package:http/http.dart';
import 'package:lit/data/models/booking.dart';
import 'package:lit/data/services/booking/network_service.dart';

class BookingRepository {
  final BookingNetworkService networkService;
  BookingRepository(this.networkService);

  Future<Response> setBooking(Booking booking) async {
    return await networkService.setBooking(booking);
  }

  Future<Response> getBooking() async {
    return await networkService.getBooking();
  }
}
