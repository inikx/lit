import 'package:flutter/material.dart';
import 'package:lit/data/models/booking.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class BookingWidget extends StatefulWidget {
  Booking booking;
  // final String title;
  // final String name;
  // final String date;
  // final String time;
  // final int personCount;
  // final String comment;

  BookingWidget({Key? key, required this.booking
      // required this.title,
      // required this.name,
      // required this.personCount,
      // required this.date,
      // required this.time,
      // required this.comment,
      })
      : super(key: key);

  @override
  State<BookingWidget> createState() => _BookingWidgetState();
}

class _BookingWidgetState extends State<BookingWidget> {
  late DateFormat dateFormatDM;
  late DateFormat dateFormatT;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    dateFormatDM = DateFormat.MMMMd('ru');
    dateFormatT = DateFormat.jm('ru');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: 250,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.blueGrey.withOpacity(0.25),
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Text("Название ресторана: "),
                        Expanded(
                          child: Text(widget.booking.title,
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  overflow: TextOverflow.visible)),
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Text("Имя гостя: "),
                      Text(widget.booking.name,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600))
                    ],
                  ),
                  Row(
                    children: [
                      Text("Количество гостей: "),
                      Text(widget.booking.personCount.toString(),
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600))
                    ],
                  ),
                  Row(
                    children: [
                      Text("Дата: "),
                      Text(dateFormatDM.format(widget.booking.timeOfBooking!),
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600))
                    ],
                  ),
                  Row(
                    children: [
                      Text("Время: "),
                      Text(dateFormatT.format(widget.booking.timeOfBooking!),
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600))
                    ],
                  ),
                  Row(
                    children: [
                      Text("Комментарий: "),
                      Expanded(
                        child: Text(
                            widget.booking.comment != ""
                                ? widget.booking.comment
                                : "-",
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                overflow: TextOverflow.visible)),
                      )
                    ],
                  ),
                ],
              ),
            )));
  }
}
