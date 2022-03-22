import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:lit/presentation/pages/restaurant_page.dart';
import 'package:provider/provider.dart';
import 'package:lit/data/models/user_location.dart';
import 'package:lit/data/provider/location_provider.dart';
import 'package:lit/data/services/location_service.dart';

class Maps extends StatefulWidget {
  const Maps({Key? key}) : super(key: key);
  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
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
          child: MapPage()),
    );
  }
}

const double cameraZoom = 15;
const double cameraTilt = 50;
const double cameraBearing = 30;

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

final places =
    GoogleMapsPlaces(apiKey: "AIzaSyC9rwCAKSPVSibz8vHHFT4bCdBCVgj8C1M");

class _MapPageState extends State<MapPage> {
  late Position position;
  late GoogleMapController mapControler;
  late Completer<GoogleMapController> _controller = Completer();
  late LatLng lastPosition;
  Set<Marker> _markers = {};

  void dispose() {
    LocationServices().closeLocation();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> _showNearbyRestaurants(double lat, double lng) async {
    PlacesSearchResponse _response = await places.searchNearbyWithRadius(
        Location(lat: lat, lng: lng),
        1000, //в зависимости от расстояния отображается меньше ресторанов
        type: "restaurant");

    Set<Marker> _restaurantMarkers = _response.results
        .map((result) => Marker(
              markerId: MarkerId(result.name),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueAzure),
              infoWindow: InfoWindow(
                  title: result.name,
                  snippet: "Ratings: " + (result.rating.toString()),
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RestarauntPage(
                                title: result.name,
                                kitchenType: "",
                                address: result.formattedAddress,
                                rating: result.rating,
                                image: Image.network(
                                  "http://c.files.bbci.co.uk/9017/production/_105278863_gettyimages-855098134.jpg",
                                  fit: BoxFit.cover,
                                ),
                                price: result.priceLevel,
                                description: "",
                              )))),
              position: LatLng(
                  result.geometry!.location.lat, result.geometry!.location.lng),
            ))
        .toSet();

    setState(() {
      _markers.addAll(_restaurantMarkers);
    });
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
          title: const Text('Поиск', style: TextStyle(color: Colors.black)),
        ),
        body: Consumer(builder: (context, LocationProvider provider, _) {
          if (provider.status == LocationProviderStatus.Loading ||
              provider.status == LocationProviderStatus.Initial) {
            return Center(child: CircularProgressIndicator());
          } else if (provider.status == LocationProviderStatus.Success) {
            var locationProvider = Provider.of<UserLocation>(context);

            CameraPosition initialCameraPosition = CameraPosition(
                zoom: cameraZoom,
                target: LatLng(
                    locationProvider.latitude, locationProvider.longitude));
            if (_markers.isEmpty) {
              _showNearbyRestaurants(
                  locationProvider.latitude, locationProvider.longitude);
            }
            return Stack(children: [
              GoogleMap(
                markers: _markers,
                initialCameraPosition: initialCameraPosition,
                myLocationEnabled: true,
                mapToolbarEnabled: true,
                mapType: MapType.normal,
                myLocationButtonEnabled: true,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
            ]);
          } else {
            return Center(
                child: Text("Мы не можем получить ваше местоположение :("));
          }
        }));
  }

  void animatedViewofMap({double? lat, double? lng}) async {
    CameraPosition cPosition = CameraPosition(
      zoom: cameraZoom,
      target: LatLng(lat!, lng!),
    );
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
  }
}
