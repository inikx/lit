import 'package:http/http.dart';
import 'package:lit/data/models/booking.dart';
import 'package:lit/data/services/booking/network_service.dart';

class BookingRepository {
  final BookingNetworkService networkService;
  BookingRepository(this.networkService);

  Future<Response> setBooking(Booking booking) async {
    return await networkService.setBooking(booking);
  }

  // Future<Response> get_all_bookings() async {
  //   return await networkService.get_all_bookings();
  // }

  // Future<Response> update_task(Task task) async {
  //   return await networkService.update_task(task);
  // }

  // Future<Response> cancel_booking(int booking_id) async {
  //   return await networkService.cancel_booking(id);
  // }

}
