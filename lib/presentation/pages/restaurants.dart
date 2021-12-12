import 'package:flutter/material.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:lit/presentation/widgets/restaurants_list.dart';

class Restaurants extends StatelessWidget {
  const Restaurants({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const Pad(top: 47),
        child: Column(children: [
          const Padding(
              padding: Pad(left: 5),
              child: TextField(
                autofocus: false, //fix autofocus
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'Введите адрес',
                  hintStyle: TextStyle(
                    fontSize: 15,
                  ),
                  border: InputBorder.none,
                ),
              )),
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
                    top: BorderSide(width: 1, color: Colors.grey),
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
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    context: context,
                    builder: (context) {
                      return Column(
                        children: <Widget>[
                          Row(
                            children: [
                              //filters
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
                    top: BorderSide(width: 1, color: Colors.grey),
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
              height: MediaQuery.of(context).size.height - 208,
              child: RestaurantsList()),
        ]));
  }
}
