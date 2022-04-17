import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:lit/data/models/booking.dart';
import 'package:lit/data/services/booking/repository.dart';

part 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  final BookingRepository repository;
  BookingCubit(this.repository) : super(BookingInitial());

  // void fetchBookings() {
  //   emit(BookingsLoading());
  //   repository.get_all_bookings().then((response) {
  //     if (response.statusCode == 200) {
  //       var rawBookings = jsonDecode(response.body) as List;
  //       List<Booking> bookings =
  //           rawBookings.map((task) => Booking.fromJson((task))).toList();
  //       emit(BookingsLoaded(bookings: bookings));
  //     } else {
  //       emit(BookingsLoadingError());
  //     }
  //   });
  // }

  // void update_task(Booking task) {
  //   var currentBookings = state.bookings;
  //   repository.update_task(task).then((response) {
  //     if (response.statusCode == 200) {
  //       if (state is BookingsLoaded || state is BookingUpdated) {
  //         currentBookings
  //             .removeWhere((stateBooking) => stateBooking.id == task.id);
  //         currentBookings.add(task);
  //         emit(BookingUpdated(bookings: currentBookings));
  //       }
  //     } else {
  //       emit(BookingUpdatingError());
  //     }
  //   });
  // }

  // updateBookingInState(Booking task) {
  //   var currentBookings = state.bookings;
  //   currentBookings.removeWhere((stateBooking) => stateBooking.id == task.id);
  //   currentBookings.add(task);
  //   emit(BookingUpdated(bookings: currentBookings));
  // }

  setBookingToState(Booking booking) {
    final currentState = state;
    final bookings = currentState.bookings;
    bookings.add(booking);
    emit(BookingsLoaded(bookings: bookings));
  }

  // void remove_task(int id) {
  //   final bookings = state.bookings;
  //   repository.delete_boobking(id).then((response) {
  //     if (response.statusCode == 200) {
  //       bookings.removeWhere((element) => element.id == id);
  //       emit(BookingsLoaded(bookings: bookings));
  //     } else {
  //       emit(BookingRemovingError());
  //       emit(BookingsLoaded(bookings: bookings));
  //     }
  //   });
  // }
}
