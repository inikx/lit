import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:lit/presentation/pages/booking_status.dart';
import 'package:lit/presentation/widgets/restaurants_list.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class Restaurants extends StatelessWidget {
  const Restaurants({Key? key}) : super(key: key);

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
          title: const Text('Рестораны', style: TextStyle(color: Colors.black)),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.search,
                    size: 26.0,
                  ),
                )),
          ]),
      body: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            InkWell(
              onTap: () {
                showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    context: context,
                    builder: (context) {
                      return Column(
                        children: <Widget>[
                          Row(
                            children: [
                              //sort
                            ],
                          )
                        ],
                      );
                    });
              },
              child: Container(
                  padding: const Pad(all: 10),
                  width: MediaQuery.of(context).size.width / 2,
                  decoration: const BoxDecoration(
                      border: Border(
                    //top: BorderSide(width: 1, color: Colors.grey),
                    bottom: BorderSide(width: 1, color: Colors.grey),
                    right: BorderSide(width: 0.5, color: Colors.grey),
                  )),
                  child: const Center(
                      child: Text(
                    "Сортировать",
                    style: TextStyle(fontSize: 15),
                  ))),
            ),
            InkWell(
              onTap: () {
                showModalBottomSheet(
                    //fix
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Кухня"),
                                    SizedBox(height: 15),
                                    Text("Средний чек"),
                                    SizedBox(height: 15),
                                    Text("Рейтинг"),
                                    SizedBox(height: 15),
                                    Text("Расстояние"),
                                    SizedBox(height: 15),
                                    Text("Верификация Lit"),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text("Японская"),
                                    SizedBox(height: 15),
                                    Text("r icons"),
                                    SizedBox(height: 15),
                                    Text("star icons"),
                                    SizedBox(height: 15),
                                    Text("slider"),
                                    SizedBox(height: 15),
                                    // Container(
                                    //     width: double.maxFinite,
                                    //     child: CupertinoSlider(
                                    //         min: 0.0,
                                    //         max: 100.0,
                                    //         value: 20,
                                    //         onChanged: (value) {})),
                                    Text("icon"),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(height: 15),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.black,
                              ),
                              onPressed: () {},
                              child: Text("Подтвердить",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  )),
                            )
                          ],
                        ),
                      );
                    });
              },
              child: Container(
                  padding: const Pad(all: 10),
                  width: MediaQuery.of(context).size.width / 2,
                  decoration: const BoxDecoration(
                      border: Border(
                    //top: BorderSide(width: 1, color: Colors.grey),
                    bottom: BorderSide(width: 1, color: Colors.grey),
                    left: BorderSide(width: 0.5, color: Colors.grey),
                  )),
                  child: const Center(
                      child: Text(
                    "Фильтры",
                    style: TextStyle(fontSize: 15),
                  ))),
            ),
          ]),
          SizedBox(
              height: MediaQuery.of(context).size.height - 220,
              child: RestaurantsList()),
        ],
      ),
    );
  }
}
