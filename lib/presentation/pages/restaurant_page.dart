import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';
import 'booking_status.dart';

class RestarauntPage extends StatelessWidget {
  final String title;
  final String kitchenType;
  final String? address;
  final num? rating;
  final Image image;
  final PriceLevel? price;
  final String description;

  const RestarauntPage({
    Key? key,
    required this.title,
    required this.kitchenType,
    required this.address,
    required this.rating,
    required this.image,
    required this.price,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        toolbarHeight: 48,
        title: Text(
          title,
          style: const TextStyle(color: Colors.black),
          textAlign: TextAlign.center,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
                height: 200, //?
                width: MediaQuery.of(context).size.width,
                child: image),
            Padding(
              padding:
                  const EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
              child: Column(children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Кухня",
                          style: TextStyle(
                            fontSize: 20,
                            //fontWeight: FontWeight.w600 ?
                          )),
                      const SizedBox(width: 255), //FIX
                      Text(rating.toString()),
                      const Icon(Icons.star, size: 18) //5 rating icons ?
                    ]),
                const SizedBox(height: 5),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(kitchenType, style: const TextStyle(fontSize: 15)),
                      Text(price.toString()) //3 price icons
                    ]),
                const SizedBox(height: 20),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Описание",
                          style: TextStyle(
                            fontSize: 20,
                            //fontWeight: FontWeight.w600 ?
                          )),
                    ]),
                const SizedBox(height: 5),
                Text(
                  description,
                  style: const TextStyle(fontSize: 15),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          //button
                        },
                        icon: const Icon(Icons.location_on, size: 35)),
                    const SizedBox(width: 15),
                    IconButton(
                        onPressed: () {
                          //button
                        },
                        icon: const Icon(Icons.local_phone, size: 35)),
                    const SizedBox(
                      width: 200, //FIX
                    ),
                    IconButton(
                        onPressed: () {
                          //button add in bookmarks
                        },
                        icon: const Icon(Icons.bookmark_border,
                            size: 35)), //icon change
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
                  bookingInput(context);
                },
                child: const Text("Бронировать",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}

bookingInput(BuildContext context) {
  return showModalBottomSheet(
      //mb in widget?
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      isScrollControlled: true,
      context: context,
      builder: (context) {
        int numberOfperson = 0; //
        return FractionallySizedBox(
            heightFactor: 0.8, //keyboard on other devices?
            child: Column(
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.only(left: 30.0, right: 30.0, top: 15),
                  child: Column(
                    children: [
                      Container(
                          height: 8,
                          width: 80,
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8)))),
                      const SizedBox(height: 15),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const <Widget>[
                            Text("Ваше имя"),
                            SizedBox(width: 150),
                            Flexible(
                                child: TextField(
                                    textAlign: TextAlign.right,
                                    autofocus: true,
                                    textCapitalization:
                                        TextCapitalization.words,
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
                          const Text("Количество персон"),
                          const SizedBox(width: 100),
                          SizedBox(
                            height: 30,
                            width: 30,
                            child: FloatingActionButton(
                              child: const Icon(Icons.remove,
                                  color: Colors.black, size: 15),
                              backgroundColor: Colors.white,
                              onPressed: () {
                                // setState(() {
                                //   numberOfperson++;
                                // });
                              },
                            ),
                          ),
                          Text('$numberOfperson'), //add button work
                          SizedBox(
                            height: 30,
                            width: 30,
                            child: FloatingActionButton(
                                onPressed: () {
                                  // setState(() {
                                  //   numberOfperson--;
                                  // });
                                },
                                child: const Icon(Icons.add,
                                    color: Colors.black, size: 15),
                                backgroundColor: Colors.white),
                          )
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text("Дата"),
                            Text("23 окт") //add showDatePicker
                          ]),
                      const SizedBox(height: 15),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text("Время"),
                            Text("19:00") //add showDatePicker
                          ]),
                      const SizedBox(height: 15),
                      TextField(
                          autofocus: false,
                          textCapitalization: TextCapitalization.sentences,
                          decoration: InputDecoration(
                            hintText: 'Комментарий',
                            hintStyle: const TextStyle(
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
                      const SizedBox(height: 15),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const BookingStatusPage(
                                      // TextFields -> BookingStatusPage Globalkey?
                                      title: "Пхали-Хинкали",
                                      date: "25 сентября",
                                      time: "19:00",
                                      personCount: "8",
                                      comment:
                                          "Можем задержаться на 20 минут"))); //fix bottomNavigation
                        },
                        child: const Text("Подтвердить",
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
}
