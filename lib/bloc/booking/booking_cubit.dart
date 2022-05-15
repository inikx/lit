import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:lit/data/models/booking.dart';
import 'package:lit/data/services/booking/repository.dart';

part 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  final BookingRepository repository;
  BookingCubit(this.repository) : super(BookingInitial());

  void fetchBookings() {
    emit(BookingsLoading());
    repository.getBooking().then((response) {
      if (response.statusCode == 200) {
        var rawBookings = jsonDecode(response.body) as List;
        List<Booking> bookings =
            rawBookings.map((task) => Booking.fromJson((task))).toList();
        emit(BookingsLoaded(bookings: bookings));
      } else {
        emit(BookingsLoadingError());
      }
    });
  }

  void getLastBooking(Booking userBooking) {
    repository.getBooking().then((response) {
      if (response.statusCode == 200) {
        var rawBookings = jsonDecode(response.body) as List;
        List<Booking> bookings =
            rawBookings.map((bookin) => Booking.fromJson((bookin))).toList();

        Booking booking = bookings
            .where((element) => element.id == userBooking.id)
            .toList()[0];
        if (booking.status == "created") {
          emit(BookingCreated(booking: booking));
        } else if (booking.status == "confirmed") {
          emit(BookingConfirmed(booking: booking));
        } else if (booking.status == "canceled") {
          emit(BookingCanceled(booking: booking));
        } else {
          emit(BookingsLoadingError());
        }
      }
    });
  }

  setBookingToState(Booking booking) {
    if (state is BookingsLoaded) {
      final bookings = state.bookings;
      bookings.add(booking);
      emit(BookingsLoaded(bookings: bookings));
    }
  }
}
