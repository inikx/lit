import 'package:flutter/material.dart';
import 'package:lit/presentation/pages/booking_status.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class Booking extends StatelessWidget {
  const Booking({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          title: const Text(
            'Бронирование', //title
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.white,
          toolbarHeight: 48,
        ),
        body: Column(children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Ваше имя"),
                SizedBox(width: 245),
                Flexible(
                    child: TextField(
                        autofocus: false, //fix autofocus
                        decoration: InputDecoration(
                          hintText: 'Введите имя',
                          hintStyle: TextStyle(
                            fontSize: 15,
                          ),
                          border: InputBorder.none,
                        ))),
              ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Количество персон"),
              Text("2") //- +
            ],
          ),
          SizedBox(height: 15),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("Дата и время"),
            Text("23 окт - 19:30") //date time
          ]),
          SizedBox(height: 15),
          TextField(
              autofocus: false, //fix autofocus
              decoration: InputDecoration(
                hintText: 'Комментарий',
                hintStyle: TextStyle(
                  fontSize: 15,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                fillColor: Colors.grey[200],
                filled: true,
              )),
          SizedBox(height: 15),
          ElevatedButton(
            //aligment bottom
            style: ElevatedButton.styleFrom(
              primary: Colors.black,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BookingStatus()));
            },
            child: Text("Подтвердить",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                )),
          )
        ]));
  }
}
