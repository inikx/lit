part of 'set_booking_cubit.dart';

abstract class SetBookingState {
  late Booking booking;
}

class SetBookingInitial extends SetBookingState {
  final Booking booking =
      Booking(timeOfBooking: DateTime.now(), timeOfOrder: DateTime.now()
          //?
          );
  SetBookingInitial({booking});
}

class SetingBookingDataChanged extends SetBookingState {
  final Booking booking;
  SetingBookingDataChanged({required this.booking});
}

class SetingBooking extends SetBookingState {}

class SetingBookingSuccess extends SetBookingState {}

class SetingBookingError extends SetBookingState {
  final Booking booking;
  SetingBookingError({required this.booking});
}
