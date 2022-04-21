import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lit/presentation/widgets/booking/booking.dart';

class BookingStatusPage extends StatelessWidget {
  final String title;
  final String name;
  final String date;
  final String time;
  final int personCount;
  final String comment;

  const BookingStatusPage({
    Key? key,
    required this.title,
    required this.name,
    required this.personCount,
    required this.date,
    required this.time,
    required this.comment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
          toolbarHeight: 48,
          title: Text(
            "Бронирование",
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  //cancel booking
                },
                icon: Icon(
                  Icons.close,
                  color: Colors.red,
                ))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BookingWidget(
                  title: title,
                  name: name,
                  personCount: personCount,
                  date: date,
                  time: time,
                  comment: comment),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  Container(
                    height: 9,
                    width: 9,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(100)),
                  ),
                  Container(
                    height: 9,
                    width: 9,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(100)),
                  ),
                  Container(
                    height: 9,
                    width: 9,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(100)),
                  ),
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
                      Icons.chat,
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    height: 9,
                    width: 9,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(100)),
                  ),
                  Container(
                    height: 9,
                    width: 9,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(100)),
                  ),
                  Container(
                    height: 9,
                    width: 9,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(100)),
                  ),
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
                      Icons.check_rounded,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                  "Звонок в ресторан...", //Бронирование..., Бронирование успешно
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
