import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:geocoding/geocoding.dart';
import 'package:lit/bloc/booking/booking_cubit.dart';
import 'package:lit/bloc/restaurant/restaurant_cubit.dart';
import 'package:lit/data/providers/location_provider.dart';
import 'package:lit/presentation/pages/map.dart';
import 'package:lit/presentation/widgets/snackbars/error_snackbar.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:lit/data/models/restaurant.dart';
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
  late bool addFav;
  List<String> fixedImages = [];
  bool bookingCreated = false;

  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  @override
  void initState() {
    BlocProvider.of<RestaurantCubit>(context).isFav(widget.restaurant);
    BlocProvider.of<BookingCubit>(context).fetchBookings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    for (var image in widget.restaurant.imagePath) {
      fixedImages.add("https://cdn.images.restoclub.ru" + image);
    }
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
          child: Column(children: [
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
                items: widget.restaurant.imagePath.first.startsWith("h")
                    ? widget.restaurant.imagePath
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
                        .toList()
                    : fixedImages
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
                          Flexible(
                            child: Text(widget.restaurant.kitchen.join(", "),
                                style: const TextStyle(
                                    fontSize: 15, fontStyle: FontStyle.italic)),
                          ),
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
                    //workingHours fixies
                    Builder(builder: (context) {
                      String text = "";
                      if (widget.restaurant.workingHours.length == 20 ||
                          widget.restaurant.workingHours.length == 16) {
                        text = widget.restaurant.workingHours;
                      } else if (widget.restaurant.workingHours.length == 24) {
                        text = "Нет данных";
                      } else if (widget.restaurant.workingHours.length == 35) {
                        text = widget.restaurant.workingHours.substring(0, 15) +
                            "\n" +
                            widget.restaurant.workingHours.substring(15, 35);
                      } else if (widget.restaurant.workingHours.length == 36) {
                        text = widget.restaurant.workingHours;
                      } else if (widget.restaurant.workingHours.length == 40) {
                        text = widget.restaurant.workingHours.substring(0, 20) +
                            "\n" +
                            widget.restaurant.workingHours.substring(20, 40);
                      } else if (widget.restaurant.workingHours.length == 50) {
                        text = widget.restaurant.workingHours.substring(0, 20) +
                            "\n" +
                            widget.restaurant.workingHours.substring(20, 33) +
                            "\n" +
                            widget.restaurant.workingHours.substring(33, 50);
                      } else if (widget.restaurant.workingHours.length == 54) {
                        text = widget.restaurant.workingHours.substring(0, 20) +
                            "\n" +
                            widget.restaurant.workingHours.substring(20, 37) +
                            "\n" +
                            widget.restaurant.workingHours.substring(37, 54);
                      } else if (widget.restaurant.workingHours.length == 56) {
                        text = widget.restaurant.workingHours.substring(0, 20) +
                            "\n" +
                            widget.restaurant.workingHours.substring(20, 56);
                      } else if (widget.restaurant.workingHours.length == 57) {
                        text = widget.restaurant.workingHours.substring(0, 20) +
                            "\n" +
                            widget.restaurant.workingHours.substring(20, 40) +
                            "\n" +
                            widget.restaurant.workingHours.substring(40, 57);
                      } else if (widget.restaurant.workingHours.length == 71) {
                        text = widget.restaurant.workingHours.substring(0, 20) +
                            "\n" +
                            widget.restaurant.workingHours.substring(20, 37) +
                            "\n" +
                            widget.restaurant.workingHours.substring(37, 54) +
                            "\n" +
                            widget.restaurant.workingHours.substring(54, 71);
                      } else if (widget.restaurant.workingHours.length == 73) {
                        text = widget.restaurant.workingHours.substring(0, 20) +
                            "\n" +
                            widget.restaurant.workingHours.substring(20, 56) +
                            "\n" +
                            widget.restaurant.workingHours.substring(56, 73);
                      } else if (widget.restaurant.workingHours.length == 91) {
                        text = widget.restaurant.workingHours.substring(0, 17) +
                            "\n" +
                            widget.restaurant.workingHours.substring(17, 34) +
                            "\n" +
                            widget.restaurant.workingHours.substring(34, 54) +
                            "\n" +
                            widget.restaurant.workingHours.substring(54, 71) +
                            "\n" +
                            widget.restaurant.workingHours.substring(71, 91);
                      }
                      return Text(text,
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              overflow: TextOverflow.ellipsis));
                    }),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            height: 40,
                            width: 140,
                            child: BlocListener<BookingCubit, BookingState>(
                              listener: (context, state) {
                                if (state.bookings
                                    .where((booking) =>
                                        booking.status == "created")
                                    .isNotEmpty) {
                                  setState(() {
                                    bookingCreated = true;
                                  });
                                }
                              },
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.black),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ))),
                                  onPressed: () {
                                    if (widget.restaurant.phone != "" &&
                                        bookingCreated == false) {
                                      BookingInputBottomSheet(
                                          context,
                                          widget.restaurant.title,
                                          widget.restaurant.phone);
                                    } else if (bookingCreated == true) {
                                      showTopSnackBar(
                                          context,
                                          const ErrorSnackbar(
                                              info:
                                                  "Дождитесь результатов бронирования"));
                                    } else if (widget.restaurant.phone == "") {
                                      showTopSnackBar(
                                          context,
                                          const ErrorSnackbar(
                                              info:
                                                  "Номер телефона ресторана не найден"));
                                    }
                                  },
                                  child: Text("Забронировать",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ))),
                            )),
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
                                            builder: ((context) => GMap(
                                                restaurants: restaurants))))
                                    .then((value) => print(value.toString()));
                                ;
                              } catch (e) {
                                showTopSnackBar(
                                    context,
                                    const ErrorSnackbar(
                                        info: "Данный адрес не найден"));
                              }
                            },
                            icon: const Icon(Icons.location_on, size: 35)),
                        IconButton(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onPressed: () {
                              widget.restaurant.phone != ""
                                  ? makePhoneCall(widget.restaurant.phone)
                                  : showTopSnackBar(
                                      context,
                                      const ErrorSnackbar(
                                          info:
                                              "Номер телефона ресторана не найден"));
                            },
                            icon: const Icon(Icons.local_phone, size: 35)),
                        BlocBuilder<RestaurantCubit, RestaurantState>(
                            builder: (context, state) {
                          if (state is RestaurantsLoaded) {
                            var fav = state.fav;
                            return IconButton(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onPressed: () {
                                  fav == true
                                      ? BlocProvider.of<RestaurantCubit>(
                                              context)
                                          .deleteFav(widget.restaurant.id)
                                      : BlocProvider.of<RestaurantCubit>(
                                              context)
                                          .addFav(widget.restaurant.id);
                                },
                                icon: fav == true
                                    ? Icon(Icons.bookmark, size: 35)
                                    : Icon(Icons.bookmark_border, size: 35));
                          } else {
                            return SizedBox();
                          }
                        }),
                      ],
                    ),
                  ]),
            ),
          ]),
        ));
  }
}
