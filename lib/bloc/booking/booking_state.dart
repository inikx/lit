// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'booking_cubit.dart';

@immutable
abstract class BookingState {
  late List<Booking> bookings;
  late Booking booking;
  late String? previousStatus;
}

class BookingInitial extends BookingState {}

class BookingsLoading extends BookingState {
  final String? previousStatus;

  BookingsLoading({this.previousStatus});
}

class BookingsLoaded extends BookingState {
  final List<Booking> bookings;

  BookingsLoaded({required this.bookings});
}

class BookingsLoadingError extends BookingState {}

class BookingLoaded extends BookingState {
  final Booking booking;

  BookingLoaded({
    required this.booking,
  });
}

class BookingConfirmed extends BookingState {
  final Booking booking;
  BookingConfirmed({
    required this.booking,
  });
}

class BookingCreated extends BookingState {
  final Booking booking;
  BookingCreated({
    required this.booking,
  });
}

class BookingCanceled extends BookingState {
  final Booking booking;
  BookingCanceled({
    required this.booking,
  });
}
