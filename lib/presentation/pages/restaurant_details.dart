import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:lit/bloc/restaurant/restaurant_cubit.dart';
import 'package:lit/constants/strings.dart';
import 'package:lit/data/models/user_location.dart';
import 'package:lit/data/providers/location_provider.dart';
import 'package:lit/presentation/pages/map.dart';
import 'package:lit/presentation/widgets/snackbars/error_snackbar.dart';
import 'package:lit/route.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:lit/bloc/booking/booking_cubit.dart';
import 'package:lit/bloc/set_booking/set_booking_cubit.dart';
import 'package:lit/constants/locator.dart';
import 'package:lit/data/models/restaurant.dart';
import 'package:lit/data/services/booking/repository.dart';
import 'package:lit/presentation/widgets/bottom_sheets/booking_input_bottom_sheet.dart';

class RestarauntDetails extends StatefulWidget {
  Restaurant restaurant;

  RestarauntDetails({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  @override
  State<RestarauntDetails> createState() => _RestarauntDetailsState();
}

class _RestarauntDetailsState extends State<RestarauntDetails> {
  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

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
            widget.restaurant.title,
            style: const TextStyle(color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.height / 3.4,
                    aspectRatio: 2.0,
                    enableInfiniteScroll: false,
                    enlargeCenterPage: true,
                    autoPlay: true,
                  ),
                  items: widget.restaurant.imagePath
                      .map((item) => Container(
                            child: Center(
                                child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.network(
                                item,
                                fit: BoxFit.cover,
                                width: 1000,
                                height: 500,
                              ),
                            )),
                          ))
                      .toList(),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Кухня",
                                style: TextStyle(
                                  fontSize: 20,
                                )),
                            Row(
                              children: [
                                Text(widget.restaurant.rating != 0
                                    ? widget.restaurant.rating.toString()
                                    : "Нет оценок"),
                                Icon(Icons.star, size: 18)
                              ],
                            ),
                          ]),
                      const SizedBox(height: 5),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(widget.restaurant.kitchen.join(", "),
                                style: const TextStyle(
                                    fontSize: 15, fontStyle: FontStyle.italic)),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 3, 0),
                              child: Text(widget.restaurant.averagePrice != 0
                                  ? widget.restaurant.averagePrice.toString() +
                                      " ₽"
                                  : "Нет данных ₽"),
                            )
                          ]),
                      const SizedBox(height: 10),
                      Text("Описание",
                          style: TextStyle(
                            fontSize: 20,
                          )),
                      const SizedBox(height: 5),
                      Text(
                        widget.restaurant.shortDescription,
                        style: const TextStyle(
                            fontSize: 15, fontStyle: FontStyle.italic),
                      ),
                      const SizedBox(height: 10),
                      Text("Время работы",
                          style: TextStyle(
                            fontSize: 20,
                          )),
                      const SizedBox(height: 5),
                      Builder(builder: (context) {
                        if (widget.restaurant.workingHours.length == 20) {
                          return Text(widget.restaurant.workingHours,
                              style: TextStyle(fontStyle: FontStyle.italic));
                        } else if (widget.restaurant.workingHours.length ==
                            24) {
                          return Text("Нет данных",
                              style: TextStyle(fontStyle: FontStyle.italic));
                        } else if (widget.restaurant.workingHours.length ==
                            36) {
                          return Text(widget.restaurant.workingHours,
                              style: TextStyle(fontStyle: FontStyle.italic));
                        } else if (widget.restaurant.workingHours.length ==
                            40) {
                          return Text(
                              widget.restaurant.workingHours.substring(0, 20) +
                                  "\n" +
                                  widget.restaurant.workingHours
                                      .substring(20, 40),
                              style: TextStyle(fontStyle: FontStyle.italic));
                        } else if (widget.restaurant.workingHours.length ==
                            57) {
                          return Text(
                              widget.restaurant.workingHours.substring(0, 20) +
                                  "\n" +
                                  widget.restaurant.workingHours
                                      .substring(20, 40) +
                                  "\n" +
                                  widget.restaurant.workingHours
                                      .substring(40, 57),
                              style: TextStyle(fontStyle: FontStyle.italic));
                        } else if (widget.restaurant.workingHours.length ==
                            71) {
                          return Text(
                              widget.restaurant.workingHours.substring(0, 20) +
                                  "\n" +
                                  widget.restaurant.workingHours
                                      .substring(20, 37) +
                                  "\n" +
                                  widget.restaurant.workingHours
                                      .substring(37, 54) +
                                  "\n" +
                                  widget.restaurant.workingHours
                                      .substring(54, 71),
                              style: TextStyle(fontStyle: FontStyle.italic));
                        } else {
                          return Text(
                              widget.restaurant.workingHours.substring(0, 17) +
                                  "\n" +
                                  widget.restaurant.workingHours
                                      .substring(17, 34) +
                                  "\n" +
                                  widget.restaurant.workingHours
                                      .substring(34, 54) +
                                  "\n" +
                                  widget.restaurant.workingHours
                                      .substring(54, 71) +
                                  "\n" +
                                  widget.restaurant.workingHours
                                      .substring(71, 91),
                              style: TextStyle(fontStyle: FontStyle.italic));
                        }
                      }),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          IconButton(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onPressed: () async {
                                try {
                                  List<geo.Location> locations =
                                      await locationFromAddress(
                                          widget.restaurant.address +
                                              ", " +
                                              widget.restaurant.city);
                                  widget.restaurant.latitude =
                                      locations[0].latitude;
                                  widget.restaurant.longitude =
                                      locations[0].longitude;
                                  var provider = Provider.of<LocationProvider>(
                                      context,
                                      listen: false);
                                  provider.getLocation();
                                  List<Restaurant> restaurants = [];
                                  restaurants.add(widget.restaurant);
                                  Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: ((context) =>
                                              GMap(restaurants: restaurants))));
                                } catch (e) {
                                  showTopSnackBar(
                                      context,
                                      const ErrorSnackbar(
                                          info: "Данный адрес не найден"));
                                }
                              },
                              icon: const Icon(Icons.location_on, size: 35)),
                          const SizedBox(width: 15),
                          IconButton(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onPressed: () {
                                makePhoneCall(widget.restaurant.phone);
                              },
                              icon: const Icon(Icons.local_phone, size: 35)),
                          const SizedBox(
                            width: 200, //FIX
                          ),
                          IconButton(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onPressed: () async {},
                              icon: Icon(Icons.bookmark_border, size: 35))
                        ],
                      ),
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0, top: 10),
                child: SizedBox(
                  height: 50,
                  width: 180,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ))),
                    onPressed: () {
                      BookingInputBottomSheet(context, widget.restaurant.title);
                    },
                    child: const Text("Забронировать",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        )),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
