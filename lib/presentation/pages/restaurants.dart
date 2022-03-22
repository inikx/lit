import 'package:flutter/material.dart';
import 'package:lit/data/provider/location_provider.dart';
import 'package:lit/presentation/pages/map.dart';
import 'package:lit/presentation/widgets/restaurants_list.dart';
import 'package:provider/provider.dart';

class RestaurantsPage extends StatelessWidget {
  const RestaurantsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<LocationProvider>(context, listen: true);
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            iconTheme: const IconThemeData(
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
                  icon: const Icon(Icons.filter_list, size: 26),
                  onPressed: () {
                    restaurantsFilters(context);
                  }),
              IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                icon: const Icon(Icons.search, size: 26),
                onPressed: () {
                  provider.getLocation();
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Maps()));
                },
              ),
            ]),
        body: SafeArea(
          child: Column(children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.45),
                    spreadRadius: 2.8,
                    blurRadius: 2.2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height - 180, //?
                      child: const RestaurantsList()),
                ],
              ),
            )
          ]),
        ));
  }
}

restaurantsFilters(BuildContext context) {
  //fix
  return showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)))),
                const SizedBox(height: 15),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
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
                            child: const Text("Сбросить",
                                style: TextStyle(
                                  height: -0.1,
                                  color: Colors.black,
                                  fontSize: 15,
                                ))),
                        const Text("Японская"),
                        const SizedBox(height: 15),
                        const Text("r icons"),
                        const SizedBox(height: 15),
                        const Text("star icons"),
                        const SizedBox(height: 15),
                        const Text("slider"),
                        const SizedBox(height: 15),
                        // Container(
                        //     width: double.maxFinite,
                        //     child: CupertinoSlider(
                        //         min: 0.0,
                        //         max: 100.0,
                        //         value: 20,
                        //         onChanged: (value) {})),
                        const Text("icon"),
                        const SizedBox(height: 80),
                        const Text("-"),
                        const SizedBox(height: 15),
                        const Text("-"),
                        const SizedBox(height: 15),
                        const Text("-"),
                        const SizedBox(height: 15),
                        const Text("-"),
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
