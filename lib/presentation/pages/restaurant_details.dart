import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_webservice/places.dart';
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
              Image.network(restaurant.imagePath), //slider
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
                        Text(restaurant.rating.toString()),
                        const Icon(Icons.star, size: 18) //5 rating icons ?
                      ]),
                  const SizedBox(height: 5),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(restaurant.kitchen,
                            style: const TextStyle(fontSize: 15)),
                        Text(restaurant.averagePrice.toString()) //3 price icons
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
                    restaurant.description,
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
                padding: const EdgeInsets.only(bottom: 10.0, top: 30),
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
          //),
        ));
  }
}
