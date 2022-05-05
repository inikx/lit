import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:lit/bloc/booking/booking_cubit.dart';
import 'package:lit/bloc/set_booking/set_booking_cubit.dart';
import 'package:lit/constants/locator.dart';
import 'package:lit/data/models/restaurant.dart';
import 'package:lit/data/services/booking/repository.dart';
import 'package:lit/presentation/widgets/bottom_sheets/booking_input_bottom_sheet.dart';

class RestarauntDetails extends StatelessWidget {
  Restaurant restaurant;

  RestarauntDetails({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

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
            restaurant.title,
            style: const TextStyle(color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                //TODO: remove
                // child: CarouselSlider(
                //   options: CarouselOptions(
                //     height: MediaQuery.of(context).size.height / 3.2,
                //     aspectRatio: 2.0,
                //     enlargeCenterPage: true,
                //     autoPlay: true,
                //   ),
                //   items: restaurant.imagePath
                //       .map((item) => Container(
                //             child: Center(
                //                 child: ClipRRect(
                //               borderRadius: BorderRadius.circular(10.0),
                //               child: Image.network(
                //                 item,
                //                 fit: BoxFit.cover,
                //                 width: 1000,
                //                 height: 500,
                //               ),
                //             )),
                //           ))
                //       .toList(),
                // ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
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
                        Text(restaurant.rating.toString()),
                        const Icon(Icons.star, size: 18)
                      ]),
                  const SizedBox(height: 5),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(restaurant.kitchen.join(", "),
                            style: const TextStyle(fontSize: 15)),
                        Text(restaurant.averagePrice.toString() + " ₽")
                      ]),
                  const SizedBox(height: 10),
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Text(restaurant.workingHours),
                    SizedBox(width: 5),
                    const Icon(Icons.access_time, size: 18)
                  ]),
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
                    restaurant.description,
                    style: const TextStyle(fontSize: 15),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      IconButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onPressed: () {
                            //button
                          },
                          icon: const Icon(Icons.location_on, size: 35)),
                      const SizedBox(width: 15),
                      IconButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onPressed: () {
                            makePhoneCall(restaurant.phone);
                          },
                          icon: const Icon(Icons.local_phone, size: 35)),
                      const SizedBox(
                        width: 200, //FIX
                      ),
                      IconButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onPressed: () {
                            //button add in bookmarks
                          },
                          icon: const Icon(Icons.bookmark_border, size: 35)),
                    ],
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0, top: 20),
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
                      BookingInputBottomSheet(context, restaurant.title);
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
