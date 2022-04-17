import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:lit/bloc/booking/booking_cubit.dart';
import 'package:lit/data/models/booking.dart';
import 'package:lit/data/services/booking/repository.dart';

part 'set_booking_state.dart';

//user_id: req.user.user_id, title: title, name:name, timeOfBooking: timeOfBooking, timeOfOrder: current_time, personCount: personCount, comment: comment, status: current_status

class SetBookingCubit extends Cubit<SetBookingState> {
  final BookingRepository repository;
  final BookingCubit bookingCubit;
  SetBookingCubit(this.repository, this.bookingCubit)
      : super(SetBookingInitial(
            booking: Booking(
                timeOfBooking: DateTime.now(),
                timeOfOrder: DateTime.now()))); //?

  void updateTitle(String title) {
    final currentState = state;
    if (currentState is SetingBookingDataChanged ||
        currentState is SetBookingInitial) {
      emit(SetingBookingDataChanged(
          booking: currentState.booking.copyWith(title: title)));
    }
  }

  void updateName(String name) {
    final currentState = state;
    if (currentState is SetingBookingDataChanged ||
        currentState is SetBookingInitial) {
      emit(SetingBookingDataChanged(
          booking: currentState.booking.copyWith(name: name)));
    }
  }

  void updateTimeOfBooking(DateTime? timeOfBooking) {
    final currentState = state;
    if (currentState is SetingBookingDataChanged ||
        currentState is SetBookingInitial) {
      emit(SetingBookingDataChanged(
          booking:
              currentState.booking.copyWith(timeOfBooking: timeOfBooking)));
    }
  }

  void updatePersonCount(int personCount) {
    final currentState = state;
    if (currentState is SetingBookingDataChanged ||
        currentState is SetBookingInitial) {
      emit(SetingBookingDataChanged(
          booking: currentState.booking.copyWith(personCount: personCount)));
    }
  }

  void updateComment(String comment) {
    final currentState = state;
    if (currentState is SetingBookingDataChanged ||
        currentState is SetBookingInitial) {
      emit(SetingBookingDataChanged(
          booking: currentState.booking.copyWith(comment: comment)));
    }
  }
  // void updateProject(List<dynamic> projectData) {
  //   final currentState = state;
  //   if (currentState is SetingBookingDataChanged ||
  //       currentState is SetBookingInitial) {
  //     emit(SetingBookingDataChanged(
  //         booking: currentState.booking.copyWith(
  //             project_id: projectData[0] != null
  //                 ? int.parse(projectData[0].toString())
  //                 : null,
  //             project_title:
  //                 projectData[1] != null ? projectData[1] : "Проект")));
  //   }
  // }

  // void dropProject() {
  //   final currentState = state;
  //   if (currentState is SetingBookingDataChanged ||
  //       currentState is SetBookingInitial) {
  //     emit(SetingBookingDataChanged(
  //         booking: currentState.booking.copyWith(project_id: -1, project_title: "")));
  //   }
  // }

  void setBooking(Booking booking) {
    final currentState = state;
    emit(SetingBooking());
    repository.setBooking(booking).then((response) {
      if (response.statusCode == 200) {
        var newBooking = jsonDecode(response.body);
        emit(SetingBookingSuccess());
        emit(SetBookingInitial());
        bookingCubit.setBookingToState(Booking.fromJson(newBooking));
      } else if (response.statusCode == 400) {
        emit(SetingBookingError(booking: currentState.booking));
      }
    });
  }
}
