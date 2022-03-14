import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BookingStatus extends StatelessWidget {
  const BookingStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 70),
      child: Column(
        children: [
          bookingRestaurantName(),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              bookingDate(),
              SizedBox(width: 70),
              bookingTime(),
            ],
          ),
          SizedBox(height: 20),
          bookingComment(),
          SizedBox(height: 25),
          bookingLogoPersonCount(),
          SizedBox(height: 230),
          bookingStatusNow(),
          SizedBox(height: 10),
          Text("Звонок в ресторан...", //Бронирование..., Бронирование успешно
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              )),
          TextButton(
              style:
                  TextButton.styleFrom(splashFactory: NoSplash.splashFactory),
              onPressed: () {
                //Отмена
              },
              child: Text("Отмена",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 15,
                  )))
        ],
      ),
    );
  }
}

bookingRestaurantName() {
  return Container(
    height: 50,
    width: 350,
    decoration: BoxDecoration(
        color: Colors.black, borderRadius: BorderRadius.circular(10)),
    alignment: Alignment.center,
    child: Text(
      //data
      "Пхали - хинкали",
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
      ),
    ),
  );
}

bookingDate() {
  return Stack(
    clipBehavior: Clip.none,
    alignment: AlignmentDirectional.topCenter,
    textDirection: TextDirection.ltr,
    children: [
      Container(
        height: 80,
        width: 180,
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(10)),
        alignment: Alignment.center,
        child: Text(
          //data
          "24 сентября",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
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
                  border: Border(
                    top: BorderSide(width: 5, color: Colors.black),
                    left: BorderSide(width: 5, color: Colors.black),
                    right: BorderSide(width: 5, color: Colors.black),
                    bottom: BorderSide(width: 5, color: Colors.black),
                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8)),
            ),
            SizedBox(width: 70),
            Container(
              height: 40,
              width: 20,
              decoration: BoxDecoration(
                  border: Border(
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
    width: 80,
    decoration: BoxDecoration(
        color: Colors.black, borderRadius: BorderRadius.circular(100)),
    alignment: Alignment.center,
    child: Text(
      //data
      "18:55",
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
      ),
    ),
  );
}

bookingComment() {
  return Container(
    height: 75,
    width: 350,
    decoration: BoxDecoration(
        color: Colors.black, borderRadius: BorderRadius.circular(10)),
    alignment: Alignment.topCenter,
    child: Padding(
      padding:
          const EdgeInsets.only(left: 15.0, top: 10, bottom: 10, right: 15),
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
        Text(
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
            color: Colors.black, borderRadius: BorderRadius.circular(100)),
        alignment: Alignment.center,
        child: Icon(
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
        child: Icon(
          Icons.person,
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
        child: Icon(
          Icons.check_rounded,
          color: Colors.white,
        ),
      ),
    ],
  );
}
