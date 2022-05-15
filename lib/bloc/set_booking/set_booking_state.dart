part of 'set_booking_cubit.dart';

abstract class SetBookingState {
  late Booking booking;
}

class SetBookingInitial extends SetBookingState {
  final Booking booking =
      Booking(timeOfBooking: DateTime.now(), timeOfOrder: DateTime.now());
  SetBookingInitial({booking});
}

class SettingBookingDataChanged extends SetBookingState {
  final Booking booking;
  SettingBookingDataChanged({required this.booking});
}

class SettingBooking extends SetBookingState {}

class SettingBookingSuccess extends SetBookingState {
  final Booking booking;
  SettingBookingSuccess({required this.booking});
}

class SettingBookingError extends SetBookingState {
  final Booking booking;
  SettingBookingError({required this.booking});
}
