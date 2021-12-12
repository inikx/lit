import 'package:flutter/material.dart';
import 'package:lit/presentation/widgets/booking.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'booking_status.dart';

class RestarauntPage extends StatelessWidget {
  const RestarauntPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: const Text(
          'title', //title
          style: TextStyle(color: Colors.black),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.white,
        toolbarHeight: 48,
      ),
      body: Column(
        children: [
          Container(
            height: 250,
            width: MediaQuery.of(context).size.width,
            child: Image.network(
              "https://incrussia.ru/wp-content/uploads/2018/10/iStock-694189032.jpg", //image
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text("Кухня", style: TextStyle(fontSize: 20)),
                Text("4,6"), //rating icon
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text("Японская", style: TextStyle(fontSize: 15)), //kitchen_type
                Text("Цена"), //price icon
              ]),
              SizedBox(height: 20),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text("Описание", style: TextStyle(fontSize: 20)),
              ]),
              Container(
                child: Text(
                    "Lorem ipsum doltur adipiscindg elit. Tellus eturicies viverra donec in imperdiet in purus viverra viverra. Fermentum ultrices in non convallis. Mattis elit, bibendum odio a."), //description
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Icon(Icons.location_on, size: 35), //button
                  SizedBox(width: 15),
                  Icon(Icons.local_phone, size: 35), //button
                  SizedBox(
                    width: 270,
                  ),
                  Icon(Icons.bookmark_border, size: 35) //button
                ],
              ),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0, top: 10),
            child: ElevatedButton(
              //aligment bottom
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
              ),
              onPressed: () {
                showModalBottomSheet<dynamic>(
                    //booking (mb in other file)
                    //Navigator.push(context,
                    //MaterialPageRoute(builder: (context) => Booking()));
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    isScrollControlled: true,
                    context: context,
                    builder: (context) {
                      return FractionallySizedBox(
                          heightFactor: 0.7,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10.0),
                                child: Column(
                                  children: [
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text("Ваше имя"),
                                          SizedBox(width: 150),
                                          Flexible(
                                              child: TextField(
                                                  textAlign: TextAlign.right,
                                                  autofocus: false,
                                                  decoration: InputDecoration(
                                                    hintText: 'Введите имя',
                                                    hintStyle: TextStyle(
                                                      fontSize: 15,
                                                    ),
                                                    border: InputBorder.none,
                                                  ))),
                                        ]),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Количество персон"),
                                        Text("- 2 +") //- +
                                      ],
                                    ),
                                    SizedBox(height: 15),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
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
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          fillColor: Colors.grey[200],
                                          filled: true,
                                        )),
                                    SizedBox(height: 15),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.black,
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    BookingStatus()));
                                      },
                                      child: Text("Подтвердить",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                          )),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ));
                    });
              },
              child: Text("Бронировать",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  )),
            ),
          )
        ],
      ),
    );
  }
}
