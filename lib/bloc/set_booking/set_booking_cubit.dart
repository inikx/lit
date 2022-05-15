import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:lit/bloc/booking/booking_cubit.dart';
import 'package:lit/data/models/booking.dart';
import 'package:lit/data/services/booking/repository.dart';

part 'set_booking_state.dart';

class SetBookingCubit extends Cubit<SetBookingState> {
  final BookingRepository repository;
  final BookingCubit bookingCubit;
  SetBookingCubit(this.repository, this.bookingCubit)
      : super(SetBookingInitial(
            booking: Booking(
                timeOfBooking: DateTime.now(), timeOfOrder: DateTime.now())));

  void updateTitle(String title) {
    final currentState = state;
    if (currentState is SettingBookingDataChanged ||
        currentState is SetBookingInitial) {
      emit(SettingBookingDataChanged(
          booking: currentState.booking.copyWith(title: title)));
    }
  }

  void updateName(String name) {
    final currentState = state;
    if (currentState is SettingBookingDataChanged ||
        currentState is SetBookingInitial) {
      emit(SettingBookingDataChanged(
          booking: currentState.booking.copyWith(name: name)));
    }
  }

  void updateTimeOfBooking(DateTime? timeOfBooking) {
    final currentState = state;
    if (currentState is SettingBookingDataChanged ||
        currentState is SetBookingInitial) {
      emit(SettingBookingDataChanged(
          booking:
              currentState.booking.copyWith(timeOfBooking: timeOfBooking)));
    }
  }

  void updatePersonCount(int personCount) {
    final currentState = state;
    if (currentState is SettingBookingDataChanged ||
        currentState is SetBookingInitial) {
      emit(SettingBookingDataChanged(
          booking: currentState.booking.copyWith(personCount: personCount)));
    }
  }

  void updateComment(String comment) {
    final currentState = state;
    if (currentState is SettingBookingDataChanged ||
        currentState is SetBookingInitial) {
      emit(SettingBookingDataChanged(
          booking: currentState.booking.copyWith(comment: comment)));
    }
  }

  void setBooking(Booking booking) {
    final currentState = state;
    emit(SettingBooking());
    repository.setBooking(booking).then((response) {
      if (response.statusCode == 201) {
        var newBooking = jsonDecode(response.body);
        emit(SettingBookingSuccess(booking: Booking.fromJson(newBooking)));
        emit(SetBookingInitial());
        bookingCubit.setBookingToState(Booking.fromJson(newBooking));
      } else if (response.statusCode == 400) {
        emit(SettingBookingError(booking: currentState.booking));
      }
    });
  }
}
