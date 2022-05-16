import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lit/bloc/booking/booking_cubit.dart';
import 'package:lit/data/models/booking.dart';
import 'package:lit/presentation/widgets/booking/bookings_list.dart';
import 'package:progress_indicators/progress_indicators.dart';

class BookingsPage extends StatefulWidget {
  const BookingsPage({Key? key}) : super(key: key);

  @override
  State<BookingsPage> createState() => _BookingsPageState();
}

class _BookingsPageState extends State<BookingsPage> {
  @override
  void initState() {
    BlocProvider.of<BookingCubit>(context).fetchBookings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
          toolbarHeight: 48,
          title: const Text(
            "Мои бронирования",
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ),
        body: SafeArea(
          child: Column(children: [
            Expanded(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: BlocBuilder<BookingCubit, BookingState>(
                  builder: (context, state) {
                    if (state is BookingsLoaded) {
                      var bookings = state.bookings;
                      List<Booking> allBookings = [];

                      for (var booking in bookings) {
                        allBookings.add(booking);
                      }
                      if (allBookings.isEmpty) {
                        return Center(child: Text("Бронирования не найдены"));
                      }
                      return BookingsList(
                          bookings: allBookings.reversed.toList());
                    } else if (state is BookingsLoading) {
                      return Center(
                          child: JumpingDotsProgressIndicator(
                        dotSpacing: 8,
                        fontSize: 80.0,
                      ));
                    } else {
                      return Center(
                          child: Text("Ошибка загрузки бронирований"));
                    }
                  },
                ),
              ),
            ),
          ]),
        ));
  }
}
