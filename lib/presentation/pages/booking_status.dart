import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BookingStatusPage extends StatelessWidget {
  final String title;
  final String name;
  final String date; //date
  final String time; //time
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
            title, //title data
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
          padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  bookingDate(date),
                  const SizedBox(width: 20),
                  bookingTime(time),
                ],
              ),
              const SizedBox(height: 20),
              bookingComment(comment), //null
              const SizedBox(height: 25),
              bookingLogoPersonCount(personCount),
              const SizedBox(height: 245),
              bookingStatusNow(),
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

bookingDate(date) {
  return Stack(
    clipBehavior: Clip.none,
    alignment: AlignmentDirectional.topCenter,
    textDirection: TextDirection.ltr,
    children: [
      Container(
        height: 80,
        width: 150,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 2),
            color: Colors.white,
            borderRadius: BorderRadius.circular(15)),
        alignment: Alignment.center,
        child: Text(
          date,
          //"24 сентября",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ),
      Positioned(
        top: -15,
        child: Row(
          children: [
            Container(
              height: 40,
              width: 20,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8)),
            ),
            const SizedBox(width: 70),
            Container(
              height: 40,
              width: 20,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8)),
            ),
          ],
        ),
      ),
    ],
  );
}

bookingTime(time) {
  return Container(
    height: 80,
    width: 150,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black, width: 2)),
    alignment: Alignment.center,
    child: Container(
      alignment: Alignment.center,
      height: 50,
      width: 100,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(15)),
      child: Text(
        time.toString(),
        //"18:30",
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
      ),
    ),
  );
}

bookingComment(comment) {
  return Container(
    height: 75,
    width: 350,
    decoration: BoxDecoration(
      border: Border.all(color: Colors.black, width: 2),
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
    ),
    alignment: Alignment.topCenter,
    child: Padding(
      padding: EdgeInsets.only(left: 15.0, top: 10, bottom: 10, right: 15),
      child: Text(
        comment, //null
        style: TextStyle(
          color: Colors.black,
          fontSize: 15,
        ),
      ),
    ),
  );
}

bookingLogoPersonCount(personCount) {
  //fix position
  return Stack(
      clipBehavior: Clip.none,
      alignment: AlignmentDirectional.topCenter,
      children: [
        Positioned(
          left: -88,
          top: -5,
          child: SvgPicture.asset(
            'assets/images/lit_logo.svg',
            semanticsLabel: 'Logo',
            width: 230,
          ),
        ),
        Text(
          personCount.toString(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ]);
}

bookingStatusNow() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(100),
        ),
        alignment: Alignment.center,
        child: const Icon(
          Icons.call,
          color: Colors.white,
        ),
      ),
      Container(
        height: 9,
        width: 9,
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(100)),
      ),
      Container(
        height: 9,
        width: 9,
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(100)),
      ),
      Container(
        height: 9,
        width: 9,
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(100)),
      ),
      Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(100)),
        alignment: Alignment.center,
        child: const Icon(
          Icons.person, //robot icon
          color: Colors.white,
        ),
      ),
      Container(
        height: 9,
        width: 9,
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(100)),
      ),
      Container(
        height: 9,
        width: 9,
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(100)),
      ),
      Container(
        height: 9,
        width: 9,
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(100)),
      ),
      Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(100)),
        alignment: Alignment.center,
        child: const Icon(
          Icons.check_rounded,
          color: Colors.white,
        ),
      ),
    ],
  );
}
