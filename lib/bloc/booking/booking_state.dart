part of 'booking_cubit.dart';

@immutable
abstract class BookingState {
  late List<Booking> bookings;
}

class BookingInitial extends BookingState {}

//! Booking load States
class BookingsLoading extends BookingState {}

class BookingsLoaded extends BookingState {
  final List<Booking> bookings;

  BookingsLoaded({required this.bookings});
}

class BookingsLoadingError extends BookingState {}

//! Booking create States
class BookingCreating extends BookingState {}

class BookingCreated extends BookingState {}

class BookingsCreatingError extends BookingState {}

//! Booking update States
class BookingUpdating extends BookingState {}

class BookingUpdated extends BookingState {
  final List<Booking> bookings;

  BookingUpdated({required this.bookings});
}

class BookingUpdatingError extends BookingState {}

//! Booking remove States
class BookingRemoving extends BookingState {}

class BookingRemoved extends BookingState {}

class BookingRemovingError extends BookingState {}
