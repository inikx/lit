import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lit/constants/storage.dart';
import 'package:lit/constants/strings.dart';
import 'package:lit/data/models/restaurant.dart';
import 'package:lit/route.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';
import 'package:lit/data/models/user_location.dart';
import 'package:lit/data/providers/location_provider.dart';
import 'package:lit/data/services/location_service.dart';
import 'package:flutter/services.dart' show rootBundle;

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
  static const googleApiKey = API_KEY;
  Completer<GoogleMapController> _controllerCompleter = Completer();
  late String _mapStyle;
  bool _mapStyleLoaded = false;

  List<Restaurant> geoRestaurants = [];
  List<Marker> restMarkers = [];
  double cityLatitude = 0;
  double cityLongitude = 0;

  @override
  void initState() {
    rootBundle.loadString('assets/map/map_style.json').then((jsonStyle) {
      setState(() {
        _mapStyle = jsonStyle;
        _mapStyleLoaded = true;
      });
    });
    geoCity();
    setMarkers();
    super.initState();
  }

  Future setMarkers() async {
    BitmapDescriptor markerbitmap = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(),
      "assets/map/pin.png",
    );

    for (var restaurant in widget.restaurants) {
      try {
        List<geo.Location> locations = await locationFromAddress(
            restaurant.address + ", " + restaurant.city);
        restaurant.latitude = locations[0].latitude;
        restaurant.longitude = locations[0].longitude;
        geoRestaurants.add(restaurant);
        setState(() {
          restMarkers.add(Marker(
              markerId: MarkerId(restaurant.title),
              position: LatLng(restaurant.latitude!, restaurant.longitude!),
              icon: markerbitmap,
              infoWindow: InfoWindow(
                  title: restaurant.title,
                  snippet: restaurant.address,
                  onTap: () => Navigator.pushNamed(context, RESTAURANT_DETAILS,
                      arguments: RestarauntDetailsArguments(
                          restaurant.id,
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
        });
      } catch (e) {}
    }
  }

  void geoCity() async {
    String? city = await storage.read(key: 'city');
    List<geo.Location> locations = await locationFromAddress(city!);
    cityLatitude = locations[0].latitude;
    cityLongitude = locations[0].longitude;
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
          if (provider.status == LocationProviderStatus.Success &&
              _mapStyleLoaded) {
            var locationProvider = Provider.of<UserLocation>(context);
            return CustomMap(
                LatLng(locationProvider.latitude, locationProvider.longitude));
          } else if (provider.status == LocationProviderStatus.Error &&
              _mapStyleLoaded) {
            return CustomMap(LatLng(cityLatitude, cityLongitude));
          } else {
            return Center(
                child: JumpingDotsProgressIndicator(
              dotSpacing: 8,
              fontSize: 80.0,
            ));
          }
        }));
  }

  Column CustomMap(LatLng target) {
    return Column(children: [
      Expanded(
        child: SizedBox(
          child: GoogleMap(
            onMapCreated: (GoogleMapController controller) {
              controller.setMapStyle(_mapStyle);
              _controllerCompleter.complete(controller);
            },
            markers: Set.from(restMarkers),
            initialCameraPosition: restMarkers.length == 1
                ? CameraPosition(
                    zoom: 15,
                    target: LatLng(widget.restaurants[0].latitude!,
                        widget.restaurants[0].longitude!))
                : CameraPosition(zoom: 12, target: target),
            myLocationEnabled: true,
            mapToolbarEnabled: true,
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
          ),
        ),
      ),
    ]);
  }
}
