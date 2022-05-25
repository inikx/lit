import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lit/bloc/booking/booking_cubit.dart';
import 'package:lit/data/models/booking.dart';
import 'package:lit/presentation/widgets/booking/booking.dart';
import 'package:progress_indicators/progress_indicators.dart';

class BookingStatusPage extends StatefulWidget {
  bool fromList;
  Booking booking;

  BookingStatusPage({Key? key, required this.fromList, required this.booking})
      : super(key: key);

  @override
  State<BookingStatusPage> createState() => _BookingStatusPageState();
}

class _BookingStatusPageState extends State<BookingStatusPage> {
  Timer? timer;

  @override
  void initState() {
    timer = Timer.periodic(
        Duration(seconds: 1),
        (Timer t) => BlocProvider.of<BookingCubit>(context)
            .getLastBooking(widget.booking));
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              iconTheme: const IconThemeData(
                color: Colors.black,
              ),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  if (widget.fromList == false) {
                    Navigator.of(context).pop(context);
                    Navigator.of(context).pop(context);
                  } else {
                    Navigator.of(context).pop(context);
                  }
                },
              ),
              backgroundColor: Colors.white,
              toolbarHeight: 48,
              title: Text(
                "Бронирование",
                style: TextStyle(color: Colors.black),
                textAlign: TextAlign.center,
              ),
              // actions: <Widget>[
              //   IconButton(
              //       onPressed: () {
              //         //cancel booking
              //       },
              //       icon: Icon(
              //         Icons.close,
              //         color: Colors.red,
              //       ))
              // ],
            ),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BookingWidget(
                    booking: Booking(
                        title: widget.booking.title,
                        name: widget.booking.name,
                        personCount: widget.booking.personCount,
                        timeOfBooking: widget.booking.timeOfBooking,
                        timeOfOrder: DateTime.now(),
                        comment: widget.booking.comment,
                        status: widget.booking.status),
                    open: false,
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      BlocBuilder<BookingCubit, BookingState>(
                          builder: (context, state) {
                        if (state is BookingCreated) {
                          return Row(
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(100.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.blueGrey.withOpacity(0.25),
                                      spreadRadius: 1,
                                      blurRadius: 8,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                ),
                                alignment: Alignment.center,
                                child: const Icon(
                                  Icons.call,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(width: 20),
                              JumpingText('Звонок в ресторан...',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                  ))
                            ],
                          );
                        } else if (state is BookingConfirmed) {
                          return Row(
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: Colors.greenAccent[700],
                                  borderRadius: BorderRadius.circular(100.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.blueGrey.withOpacity(0.25),
                                      spreadRadius: 1,
                                      blurRadius: 8,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                ),
                                alignment: Alignment.center,
                                child: const Icon(
                                  Icons.check_rounded,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 20),
                              const Text("Бронирование успешно!",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                  )),
                            ],
                          );
                        } else if (state is BookingCanceled) {
                          return Row(
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: //Color(0xff34A770),
                                      Colors.red,
                                  borderRadius: BorderRadius.circular(100.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.blueGrey.withOpacity(0.25),
                                      spreadRadius: 1,
                                      blurRadius: 8,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                ),
                                alignment: Alignment.center,
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 20),
                              const Text("Отмена бронирования",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                  )),
                            ],
                          );
                        } else {
                          return JumpingDotsProgressIndicator(
                            dotSpacing: 8,
                            fontSize: 80.0,
                          );
                        }
                      }),
                    ],
                  ),
                ],
              ),
            )));
  }
}
