import 'package:flutter/material.dart';
import 'booking_status.dart';

class RestarauntPage extends StatelessWidget {
  final String title;
  final String kitchen_type;
  final String address;
  final double rating;
  final Image image;
  final int price;
  final String description;

  const RestarauntPage({
    Key? key,
    required this.title,
    required this.kitchen_type,
    required this.address,
    required this.rating,
    required this.image,
    required this.price,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        toolbarHeight: 48,
        title: Text(
          title,
          style: TextStyle(color: Colors.black),
          textAlign: TextAlign.center,
        ),
      ),
      body: Column(
        children: [
          Container(
              height: 250,
              width: MediaQuery.of(context).size.width,
              child: image),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text("Кухня", style: TextStyle(fontSize: 20)),
                SizedBox(width: 290),
                Text(rating.toString()),
                Icon(Icons.star, size: 18) //5 rating icons
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(kitchen_type, style: TextStyle(fontSize: 15)),
                Text(price.toString()) //3 price icons
              ]),
              SizedBox(height: 20),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text("Описание", style: TextStyle(fontSize: 20)),
              ]),
              Container(
                child: Text(description, style: TextStyle(fontSize: 15)),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.location_on, size: 35)), //button
                  SizedBox(width: 15),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.local_phone, size: 35)), //button
                  SizedBox(
                    width: 220,
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.bookmark_border,
                          size: 35)), //add icon change + add in bookmarks
                  //button
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
                      int numberOfperson = 0; //
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
                                        SizedBox(width: 100),
                                        Container(
                                          height: 30,
                                          width: 30,
                                          child: FloatingActionButton(
                                            child: Icon(Icons.remove,
                                                color: Colors.black, size: 15),
                                            backgroundColor: Colors.white,
                                            onPressed: () {
                                              // setState(() {
                                              //   numberOfperson++;
                                              // });
                                            },
                                          ),
                                        ),
                                        Text(
                                            '$numberOfperson'), //add button work
                                        Container(
                                          height: 30,
                                          width: 30,
                                          child: FloatingActionButton(
                                              onPressed: () {
                                                // setState(() {
                                                //   numberOfperson--;
                                                // });
                                              },
                                              child: Icon(Icons.add,
                                                  color: Colors.black,
                                                  size: 15),
                                              backgroundColor: Colors.white),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 15),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Дата"),
                                          Text("23 окт") //add showDatePicker
                                        ]),
                                    SizedBox(height: 15),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Время"),
                                          Text("19:00") //add showDatePicker
                                        ]),
                                    SizedBox(height: 15),
                                    TextField(
                                        autofocus: false,
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
