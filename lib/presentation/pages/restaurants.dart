import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lit/bloc/restaurant/restaurant_cubit.dart';
import 'package:lit/data/models/restaurant.dart';
import 'package:lit/data/providers/location_provider.dart';
import 'package:lit/data/providers/filters_provider.dart';
import 'package:lit/presentation/pages/map.dart';
import 'package:lit/presentation/widgets/bottom_sheets/restaurants_filters_bottom_sheet.dart';
import 'package:lit/presentation/widgets/restaurant/restaurants_list.dart';
import 'package:lit/presentation/widgets/snackbars/info_snackbar.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class RestaurantsPage extends StatefulWidget {
  const RestaurantsPage({Key? key}) : super(key: key);

  @override
  State<RestaurantsPage> createState() => _RestaurantsPageState();
}

class _RestaurantsPageState extends State<RestaurantsPage> {
  final Tcontroller = TextEditingController();
  String query = "";
  final int mapRestCount = 150;

  @override
  void initState() {
    BlocProvider.of<RestaurantCubit>(context).fetchRestaurants();
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
              child: BlocBuilder<RestaurantCubit, RestaurantState>(
                builder: (context, state) {
                  if (state is RestaurantsLoaded) {
                    var restaurants = state.restaurants;
                    List<Restaurant> allRestaurants = [];
                    List kitchen =
                        context.watch<FiltersProvider>().selectedKitchens;
                    double rating = context.watch<FiltersProvider>().rating;
                    int lowPrice = context.watch<FiltersProvider>().lowPrice;
                    int maxPrice = context.watch<FiltersProvider>().maxPrice;
                    String sort = context.watch<FiltersProvider>().sort;
                    //Search
                    if (query != "") {
                      restaurants = restaurants
                          .where((restaurant) => restaurant.title
                              .toLowerCase()
                              .contains(query.toLowerCase()))
                          .toList();
                    }
                    //Filters
                    if (kitchen.isNotEmpty) {
                      restaurants = restaurants.where((restaurant) {
                        return restaurant.kitchen
                            .any((element) => kitchen.contains(element));
                      }).toList();
                    }
                    if (rating > 1) {
                      restaurants = restaurants.where((restaurant) {
                        return restaurant.rating >= rating ||
                            restaurant.rating == 0.0;
                      }).toList();
                    }
                    if (lowPrice > 0) {
                      restaurants = restaurants.where((restaurant) {
                        return restaurant.averagePrice >= lowPrice;
                      }).toList();
                    }
                    if (maxPrice < 3000) {
                      restaurants = restaurants.where((restaurant) {
                        return restaurant.averagePrice <= maxPrice;
                      }).toList();
                    }
                    //Sort
                    if (sort == "С наибольшим рейтингом") {
                      restaurants.sort((a, b) => b.rating.compareTo(a.rating));
                    } else if (sort == "Недорогие") {
                      restaurants = restaurants.where((restaurant) {
                        return restaurant.averagePrice != 0;
                      }).toList();
                      restaurants.sort(
                          (a, b) => a.averagePrice.compareTo(b.averagePrice));
                    } else if (sort == "Дорогие") {
                      restaurants.sort(
                          (a, b) => b.averagePrice.compareTo(a.averagePrice));
                    }

                    for (var restaurant in restaurants) {
                      allRestaurants.add(restaurant);
                    }
                    if (allRestaurants.isEmpty) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 60,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 20, 0, 20),
                                  child: TextField(
                                      autofocus: true,
                                      controller: Tcontroller,
                                      onChanged: (value) {
                                        setState(() {
                                          query = value;
                                        });
                                      },
                                      textCapitalization:
                                          TextCapitalization.words,
                                      cursorColor: Colors.black,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.search,
                                          color: Colors.grey,
                                        ),
                                        hintText: 'Поиск',
                                        hintStyle: TextStyle(
                                            fontSize: 15, color: Colors.grey),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 10.0),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.black),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0))),
                                        border: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.black),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0))),
                                      )),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        icon: Image.asset(
                                          'assets/icons/map.png',
                                          color: Colors.grey,
                                        ),
                                        onPressed: () {}),
                                    Text("0")
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Center(child: Text("Рестораны не найдены.")),
                        ],
                      );
                    }
                    return Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 60,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 20, 0, 20),
                                child: TextField(
                                    controller: Tcontroller,
                                    onChanged: (value) {
                                      setState(() {
                                        query = value;
                                      });
                                    },
                                    textCapitalization:
                                        TextCapitalization.words,
                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.search,
                                        color: Colors.grey,
                                      ),
                                      hintText: 'Поиск',
                                      hintStyle: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey,
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 10.0),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.black),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0))),
                                      border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.black),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0))),
                                    )),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      icon: Image.asset(
                                        'assets/icons/map.png',
                                        color:
                                            allRestaurants.length < mapRestCount
                                                ? Colors.black
                                                : Colors.grey,
                                      ),
                                      onPressed: () {
                                        if (allRestaurants.length <
                                            mapRestCount) {
                                          var provider =
                                              Provider.of<LocationProvider>(
                                                  context,
                                                  listen: false);
                                          provider.getLocation();
                                          Navigator.push(
                                              context,
                                              CupertinoPageRoute(
                                                  builder: ((context) => GMap(
                                                      restaurants:
                                                          allRestaurants))));
                                        } else {
                                          showTopSnackBar(
                                              context,
                                              const InfoSnackbar(
                                                  title: "Обратите внимание!",
                                                  info:
                                                      "На карте может быть до 150 ресторанов"));
                                        }
                                      }),
                                  Text(allRestaurants.length.toString())
                                ],
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                            child:
                                RestaurantsList(restaurants: allRestaurants)),
                      ],
                    );
                  } else if (state is RestaurantsLoading) {
                    return Center(
                        child: JumpingDotsProgressIndicator(
                      dotSpacing: 8,
                      fontSize: 80.0,
                    ));
                  } else {
                    return Center(child: Text("Ошибка загрузки ресторанов"));
                  }
                },
              ),
            ),
          ),
        ])));
  }
}
