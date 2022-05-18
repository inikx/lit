import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:lit/bloc/restaurant/restaurant_cubit.dart';
import 'package:lit/data/models/restaurant.dart';
import 'package:lit/data/providers/location_provider.dart';
import 'package:lit/data/providers/filters_provider.dart';
import 'package:lit/presentation/pages/map.dart';
import 'package:lit/presentation/pages/profile.dart';
import 'package:lit/presentation/widgets/bottom_sheets/restaurants_filters_bottom_sheet.dart';
import 'package:lit/presentation/widgets/restaurant/restaurants_list.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class RestaurantsPage extends StatefulWidget {
  const RestaurantsPage({Key? key}) : super(key: key);

  @override
  State<RestaurantsPage> createState() => _RestaurantsPageState();
}

class _RestaurantsPageState extends State<RestaurantsPage> {
  final Tcontroller = TextEditingController();
  String query = "";

  @override
  void initState() {
    //BlocProvider.of<RestaurantCubit>(context).fetchRestaurants();
    super.initState();
  }

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
                  }),
            ]),
        body: SafeArea(
            child: Column(children: [
          Expanded(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              // child: BlocBuilder<RestaurantCubit, RestaurantState>(
              //   builder: (context, state) {
              //     if (state is RestaurantsLoaded) {
              //       var restaurants = state.restaurants;
              //       List<Restaurant> allRestaurants = [];
              //       List<Restaurant> geoRestaurants = [];
              //       List kitchen =
              //           context.watch<FiltersProvider>().selectedKitchens;
              //       double rating = context.watch<FiltersProvider>().rating;
              //       int lowPrice = context.watch<FiltersProvider>().lowPrice;
              //       int maxPrice = context.watch<FiltersProvider>().maxPrice;
              //       String sort = context.watch<FiltersProvider>().sort;
              //       //Filters
              //       if (query != "") {
              //         restaurants = restaurants
              //             .where((restaurant) => restaurant.title
              //                 .toLowerCase()
              //                 .contains(query.toLowerCase()))
              //             .toList();
              //       }
              //       if (kitchen.isNotEmpty) {
              //         restaurants = restaurants.where((restaurant) {
              //           return restaurant.kitchen
              //               .any((element) => kitchen.contains(element));
              //         }).toList();
              //       }
              //       if (rating > 1) {
              //         restaurants = restaurants.where((restaurant) {
              //           return restaurant.rating >= rating ||
              //               restaurant.rating == 0.0;
              //         }).toList();
              //       }
              //       if (lowPrice > 0) {
              //         restaurants = restaurants.where((restaurant) {
              //           return restaurant.averagePrice >= lowPrice;
              //         }).toList();
              //       }
              //       if (maxPrice < 3000) {
              //         restaurants = restaurants.where((restaurant) {
              //           return restaurant.averagePrice <= maxPrice;
              //         }).toList();
              //       }
              //       if (sort != "Рекомендованные") {
              //         if (sort == "С наибольшим рейтингом") {
              //           restaurants
              //               .sort((a, b) => b.rating.compareTo(a.rating));
              //         } else if (sort == "Недорогие") {
              //           //
              //           List<Restaurant> rests = restaurants
              //               .where((element) => element.averagePrice != 0)
              //               .toList();
              //           rests.sort(
              //               (a, b) => a.averagePrice.compareTo(b.averagePrice));
              //           //restaurants
              //           //.toList();
              //         } else if (sort == "Дорогие") {
              //           restaurants.sort(
              //               (a, b) => b.averagePrice.compareTo(a.averagePrice));
              //         }
              //       }
              //       // for (var restaurant in restaurants) {
              //       //   allRestaurants.add(restaurant);
              //       // } //TODO: fix
              //       if (allRestaurants.isEmpty) {
              //         return Column(
              //           children: [
              //             Row(
              //               mainAxisAlignment: MainAxisAlignment.start,
              //               children: [
              //                 SizedBox(
              //                   width: MediaQuery.of(context).size.width - 60,
              //                   child: Padding(
              //                     padding:
              //                         const EdgeInsets.fromLTRB(20, 20, 0, 20),
              //                     child: TextField(
              //                         autofocus: true,
              //                         controller: Tcontroller,
              //                         onChanged: (value) {
              //                           setState(() {
              //                             query = value;
              //                           });
              //                         },
              //                         textCapitalization:
              //                             TextCapitalization.words,
              //                         cursorColor: Colors.black,
              //                         decoration: InputDecoration(
              //                           prefixIcon: Icon(
              //                             Icons.search,
              //                             color: Colors.grey,
              //                           ),
              //                           hintText: 'Поиск',
              //                           hintStyle: TextStyle(
              //                               fontSize: 15, color: Colors.grey),
              //                           contentPadding:
              //                               const EdgeInsets.symmetric(
              //                                   vertical: 10.0),
              //                           focusedBorder: OutlineInputBorder(
              //                               borderSide: const BorderSide(
              //                                   color: Colors.black),
              //                               borderRadius: BorderRadius.all(
              //                                   Radius.circular(10.0))),
              //                           border: OutlineInputBorder(
              //                               borderSide: const BorderSide(
              //                                   color: Colors.black),
              //                               borderRadius: BorderRadius.all(
              //                                   Radius.circular(10.0))),
              //                         )),
              //                   ),
              //                 ),
              //               ],
              //             ),
              //             Center(child: Text("Рестораны не найдены.")),
              //           ],
              //         );
              //       }
              //       return Column(
              //         children: [
              //           Row(
              //             children: [
              //               SizedBox(
              //                 width: MediaQuery.of(context).size.width - 60,
              //                 child: Padding(
              //                   padding:
              //                       const EdgeInsets.fromLTRB(20, 20, 0, 20),
              //                   child: TextField(
              //                       controller: Tcontroller,
              //                       onChanged: (value) {
              //                         setState(() {
              //                           query = value;
              //                         });
              //                       },
              //                       textCapitalization:
              //                           TextCapitalization.words,
              //                       cursorColor: Colors.black,
              //                       decoration: InputDecoration(
              //                         prefixIcon: Icon(
              //                           Icons.search,
              //                           color: Colors.grey,
              //                         ),
              //                         hintText: 'Поиск',
              //                         hintStyle: TextStyle(
              //                             fontSize: 15, color: Colors.grey),
              //                         contentPadding:
              //                             const EdgeInsets.symmetric(
              //                                 vertical: 10.0),
              //                         focusedBorder: OutlineInputBorder(
              //                             borderSide: const BorderSide(
              //                                 color: Colors.black),
              //                             borderRadius: BorderRadius.all(
              //                                 Radius.circular(10.0))),
              //                         border: OutlineInputBorder(
              //                             borderSide: const BorderSide(
              //                                 color: Colors.black),
              //                             borderRadius: BorderRadius.all(
              //                                 Radius.circular(10.0))),
              //                       )),
              //                 ),
              //               ),
              //               IconButton(
              //                   splashColor: Colors.transparent,
              //                   highlightColor: Colors.transparent,
              //                   icon: Image.asset('assets/icons/map.png'),
              //                   onPressed: () {
              //                     var provider = Provider.of<LocationProvider>(
              //                         context,
              //                         listen: false);
              //                     provider.getLocation();
              //                     Navigator.push(
              //                         context,
              //                         CupertinoPageRoute(
              //                             builder: ((context) => GMap(
              //                                 restaurants: allRestaurants))));
              //                   }),
              //             ],
              //           ),
              //           RestaurantsList(restaurants: allRestaurants),
              //         ],
              //       );
              //     } else if (state is RestaurantsLoading) {
              //       return Center(
              //           child: JumpingDotsProgressIndicator(
              //         dotSpacing: 8,
              //         fontSize: 80.0,
              //       ));
              //     } else {
              //       return Center(child: Text("Ошибка загрузки ресторанов"));
              //     }
              //   },
              // ),
            ),
          ),
        ])));
  }
}
