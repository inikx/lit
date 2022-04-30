import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lit/data/models/restaurant.dart';
import 'package:lit/data/providers/location_provider.dart';
import 'package:lit/data/providers/filters_provider.dart';
import 'package:lit/presentation/pages/map.dart';
import 'package:lit/presentation/pages/profile.dart';
import 'package:lit/presentation/widgets/bottom_sheets/restaurants_filters_bottom_sheet.dart';
import 'package:lit/presentation/widgets/restaurant/restaurants_list.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class RestaurantsPage extends StatefulWidget {
  const RestaurantsPage({Key? key}) : super(key: key);

  @override
  State<RestaurantsPage> createState() => _RestaurantsPageState();
}

class _RestaurantsPageState extends State<RestaurantsPage> {
  List<Restaurant> filteredRestaurants = [];
  List<Restaurant> allRestaurants = [
    Restaurant(
        title: "Пхали-Хинкали",
        kitchens: ["Грузинская", "Русская"],
        address: "Большая Морская ул., 27",
        rating: 4.7,
        imagePaths: [
          "https://cdn.images.restoclub.ru/uploads/place_thumbnail_big/1/2/8/c/128c1b700e3dd4d63f4dff3b699172d2.jpg",
          "https://phali-hinkali.ru/pimages/Restorans9/fdd6dcc010-1_1920x.jpg",
          "https://phali-hinkali.ru/pimages/Restorans5/40e75df9bf-1_1920x.jpg"
        ],
        averagePrice: 1000,
        description:
            "Грузинская кухня и европейское гостеприимство - семья ресторанов «Пхали Хинкали» - вкусный и душевный проект с новым качественным подходом к кавказской кухне. ",
        shortDescription: "Ресторан грузинской кухни",
        workingHours: "10-22",
        phone: "89955550404"),
    Restaurant(
        title: "Umi",
        kitchens: ["Китайская"],
        address: "ул. Разъезжая 10",
        rating: 4.8,
        imagePaths: [
          "https://cdn.images.restoclub.ru/uploads/place_thumbnail_big/6/1/d/b/61db7087cede8f68d2cf39f79c249490.jpg",
          "https://phali-hinkali.ru/pimages/Restorans9/fdd6dcc010-1_1920x.jpg",
          "https://phali-hinkali.ru/pimages/Restorans5/40e75df9bf-1_1920x.jpg"
        ],
        averagePrice: 1200,
        description:
            "Ресторан «Юми», открывшийся в начале 2016 года на улице Разъезжей, предлагает гостям аутентичную китайскую кухню в стильном современном интерьере.",
        shortDescription: "Ресторан китайской кухни",
        workingHours: "10-21",
        phone: "89952344404"),
  ];

  // context.watch<FiltersProvider>().selectedKitchens.toString()
  // void filterKitchen(String kitchen) {
  //   List<Restaurant> results = [];
  //   if (kitchen == "Любая" || kitchen == null) {
  //     setState(() {
  //       results = allRestaurants;
  //     });
  //   } else {
  //     results = allRestaurants.where((restaurant) {
  //       return restaurant.kitchens.contains(kitchen);
  //     }).toList();
  //   }
  //   setState(() {
  //     filteredRestaurants = results;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
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
                    ProjectFiltersBottomSheet(context);
                  })
            ]),
        body: SafeArea(
          child: Column(children: [
            Expanded(
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: RestaurantsList(restaurants: allRestaurants)),
            ),
          ]),
        ));
  }
}
