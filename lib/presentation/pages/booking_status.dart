import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BookingStatusPage extends StatelessWidget {
  final String title;
  final String name;
  final String date; //date
  final String time; //time
  final String personCount;
  final String comment;

  const BookingStatusPage({
    Key? key,
    //required this.name,
    required this.title,
    this.name = "Name",
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
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
          child: Column(
            children: [
              //bookingRestaurantName(),
              //SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  bookingDate(),
                  const SizedBox(width: 20),
                  bookingTime(),
                ],
              ),
              const SizedBox(height: 20),
              bookingComment(),
              const SizedBox(height: 25),
              bookingLogoPersonCount(),
              const SizedBox(height: 235),
              bookingStatusNow(),
              const SizedBox(height: 10),
              const Text(
                  "Звонок в ресторан...", //Бронирование..., Бронирование успешно
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  )),
              TextButton(
                  style: TextButton.styleFrom(
                      splashFactory: NoSplash.splashFactory),
                  onPressed: () {
                    //Отмена
                  },
                  child: const Text("Отмена",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 15,
                      )))
            ],
          ),
        ),
      ),
    );
  }
}

// bookingRestaurantName() {
//   return Container(
//     height: 50,
//     width: 350,
//     decoration: BoxDecoration(
//         color: Colors.black, borderRadius: BorderRadius.circular(10)),
//     alignment: Alignment.center,
//     child: Text(
//       //data
//       "Пхали - хинкали",
//       style: TextStyle(
//         color: Colors.white,
//         fontSize: 18,
//       ),
//     ),
//   );
// }

bookingDate() {
  return Stack(
    clipBehavior: Clip.none,
    alignment: AlignmentDirectional.topCenter,
    textDirection: TextDirection.ltr,
    children: [
      Container(
        height: 80,
        width: 165,
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(15)),
        alignment: Alignment.center,
        child: const Text(
          //data
          "24 сентября",
          style: TextStyle(
            color: Colors.white,
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
                  border: const Border(
                    top: BorderSide(width: 5, color: Colors.black),
                    left: BorderSide(width: 5, color: Colors.black),
                    right: BorderSide(width: 5, color: Colors.black),
                    bottom: BorderSide(width: 5, color: Colors.black),
                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8)),
            ),
            const SizedBox(width: 70),
            Container(
              height: 40,
              width: 20,
              decoration: BoxDecoration(
                  border: const Border(
                    top: BorderSide(width: 5, color: Colors.black),
                    left: BorderSide(width: 5, color: Colors.black),
                    right: BorderSide(width: 5, color: Colors.black),
                    bottom: BorderSide(width: 5, color: Colors.black),
                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8)),
            ),
          ],
        ),
      ),
    ],
  );
}

bookingTime() {
  return Container(
    height: 80,
    width: 165,
    decoration: BoxDecoration(
        color: Colors.black, borderRadius: BorderRadius.circular(15)),
    alignment: Alignment.center,
    child: Container(
      alignment: Alignment.center,
      height: 50,
      width: 100,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(15)),
      child: const Text(
        //data
        "18:30",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    ),
  );
}

bookingComment() {
  return Container(
    height: 75,
    width: 350,
    decoration: BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.circular(10),
    ),
    alignment: Alignment.topCenter,
    child: const Padding(
      padding: EdgeInsets.only(left: 15.0, top: 10, bottom: 10, right: 15),
      child: Text(
        //data
        "Место у окна пожалуйста, с нами будет ребенок 5 лет",
        style: TextStyle(
          color: Colors.white,
          fontSize: 15,
        ),
      ),
    ),
  );
}

bookingLogoPersonCount() {
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
        const Text(
          "9",
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
