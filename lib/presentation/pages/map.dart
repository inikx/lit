import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:lit/constants/strings.dart';
import 'package:lit/data/models/restaurant.dart';
import 'package:lit/presentation/pages/restaurant_details.dart';
import 'package:lit/route.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';
import 'package:lit/data/models/user_location.dart';
import 'package:lit/data/providers/location_provider.dart';
import 'package:lit/data/services/location_service.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GMap extends StatefulWidget {
  List<Restaurant> restaurants;
  GMap({Key? key, required this.restaurants}) : super(key: key);
  @override
  _GMapState createState() => _GMapState();
}

class _GMapState extends State<GMap> {
  @override
  void dispose() {
    LocationServices().closeLocation();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var locationProvider = Provider.of<LocationProvider>(context);

    return Scaffold(
      body: StreamProvider<UserLocation?>(
          initialData: locationProvider.userLocation,
          create: (context) => LocationServices().locationStream,
          child: MapPage(
            restaurants: widget.restaurants,
          )),
    );
  }
}

class MapPage extends StatefulWidget {
  List<Restaurant> restaurants;
  MapPage({Key? key, required this.restaurants}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  static const googleApiKey = "AIzaSyC9rwCAKSPVSibz8vHHFT4bCdBCVgj8C1M";
  final places = GoogleMapsPlaces(apiKey: googleApiKey);

  List<Restaurant> geoRestaurants = [];
  List<Marker> restMarkers = [];

  @override
  void initState() {
    addMarkers();
    super.initState();
  }

  addMarkers() async {
    BitmapDescriptor markerbitmap = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(),
      "assets/icons/pin.png",
    );

    for (var restaurant in widget.restaurants) {
      try {
        List<geo.Location> locations = await locationFromAddress(
            restaurant.address + ", " + restaurant.city);
        restaurant.latitude = locations[0].latitude;
        restaurant.longitude = locations[0].longitude;
        geoRestaurants.add(restaurant);

        restMarkers.add(Marker(
            markerId: MarkerId(restaurant.title),
            position: LatLng(restaurant.latitude!, restaurant.longitude!),
            icon: markerbitmap,
            infoWindow: InfoWindow(
                title: restaurant.title,
                snippet: restaurant.address,
                onTap: () => Navigator.pushNamed(context, RESTAURANT_DETAILS,
                    arguments: RestarauntDetailsArguments(
                        restaurant.title,
                        restaurant.city,
                        restaurant.kitchen,
                        restaurant.address,
                        restaurant.rating,
                        restaurant.imagePath,
                        restaurant.averagePrice,
                        restaurant.shortDescription,
                        restaurant.workingHours,
                        restaurant.phone)))));
      } catch (e) {}
    }
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
          title: const Text('Карта', style: TextStyle(color: Colors.black)),
        ),
        body: Consumer(builder: (context, LocationProvider provider, _) {
          if (provider.status == LocationProviderStatus.Loading ||
              provider.status == LocationProviderStatus.Initial) {
            return Center(
                child: JumpingDotsProgressIndicator(
              dotSpacing: 8,
              fontSize: 80.0,
            ));
          } else if (provider.status == LocationProviderStatus.Success) {
            var locationProvider = Provider.of<UserLocation>(context);
            return Column(children: [
              Expanded(
                child: SizedBox(
                  child: GoogleMap(
                    markers: Set.from(restMarkers),
                    initialCameraPosition: restMarkers.length == 1
                        ? CameraPosition(
                            zoom: 15,
                            target: LatLng(widget.restaurants[0].latitude!,
                                widget.restaurants[0].longitude!))
                        : CameraPosition(
                            zoom: 12,
                            target: LatLng(locationProvider.latitude,
                                locationProvider.longitude)),
                    myLocationEnabled: true,
                    mapToolbarEnabled: true,
                    mapType: MapType.normal,
                    myLocationButtonEnabled: true,
                  ),
                ),
              ),
            ]);
          } else {
            return Center(
                child: Text(
                    "Ошибка. Мы не можем получить ваше местоположение")); //fix to city
          }
        }));
  }
}
