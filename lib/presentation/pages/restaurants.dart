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
            title: const Text(
              'Рестораны',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            actions: <Widget>[
              IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  icon: Icon(Icons.filter_list, size: 26),
                  onPressed: () {
                    restaurantsFilters(context);
                  }),
              IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                icon: Icon(Icons.search, size: 26),
                onPressed: () {
                  //add search
                },
              ),
            ]),
        body: Column(children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.45),
                  spreadRadius: 2.8,
                  blurRadius: 2.2,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height - 167,
                    child: RestaurantsList()),
              ],
            ),
          )
        ]));
  }
}

restaurantsFilters(BuildContext context) {
  //fix
  showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      context: context,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.7,
          child: Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 15),
            child: Column(
              children: <Widget>[
                Container(
                    height: 8,
                    width: 80,
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.all(Radius.circular(8)))),
                SizedBox(height: 15),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Фильтры",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 20),
                        Text("Кухня"),
                        SizedBox(height: 15),
                        Text("Средний чек"),
                        SizedBox(height: 15),
                        Text("Рейтинг"),
                        SizedBox(height: 15),
                        Text("Расстояние"),
                        SizedBox(height: 15),
                        Text("Верификация Lit"),
                        SizedBox(height: 30),
                        Text(
                          "Показать сначала",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 20),
                        Text("По расстоянию"),
                        SizedBox(height: 15),
                        Text("По рейтингу"),
                        SizedBox(height: 15),
                        Text("Недорогие"),
                        SizedBox(height: 15),
                        Text("Дорогие")
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextButton(
                            style: TextButton.styleFrom(
                                splashFactory: NoSplash.splashFactory),
                            onPressed: () {},
                            child: Text("Сбросить",
                                style: TextStyle(
                                  height: -0.1,
                                  color: Colors.black,
                                  fontSize: 15,
                                ))),
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
                        SizedBox(height: 80),
                        Text("-"),
                        SizedBox(height: 15),
                        Text("-"),
                        SizedBox(height: 15),
                        Text("-"),
                        SizedBox(height: 15),
                        Text("-"),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      });
}
