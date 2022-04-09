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
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  static const googleApiKey = "AIzaSyC9rwCAKSPVSibz8vHHFT4bCdBCVgj8C1M";
  final places = GoogleMapsPlaces(apiKey: googleApiKey);
  Set<Marker> _markers = {};

  // var _controller = TextEditingController();
  // var uuid = new Uuid();
  // String? _sessionToken;
  // List<dynamic> _placeList = [];
  //late Position position;
  //late GoogleMapController mapControler;
  //late Completer<GoogleMapController> _controller = Completer();
  //late LatLng lastPosition;

  // void dispose() {
  //   LocationServices().closeLocation();
  //   super.dispose();
  // }

//sugg
  // @override
  // void initState() {
  //   super.initState();
  //   _controller.addListener(() {
  //     _onChanged();
  //   });
  // }

  // _onChanged() {
  //   if (_sessionToken == null) {
  //     setState(() {
  //       _sessionToken = uuid.v4();
  //     });
  //   }
  //   getSuggestion(_controller.text);
  // }

  // void getSuggestion(String input) async {
  //   String kPLACES_API_KEY = "AIzaSyC9rwCAKSPVSibz8vHHFT4bCdBCVgj8C1M";
  //   String type = 'establishment';
  //   var locationProvider = Provider.of<UserLocation>(context, listen: false);
  //   String locLat = locationProvider.latitude.toString();
  //   print(locLat);
  //   String locLong = locationProvider.longitude.toString();
  //   print(locLong);
  //   String baseURL =
  //       'https://maps.googleapis.com/maps/api/place/autocomplete/json';
  //   String request =
  //       '$baseURL?input=$input&language=ru&location=$locLat,$locLat&radius=10000&rankby=distance&types=$type&key=$kPLACES_API_KEY&sessiontoken=$_sessionToken';
  //   var response = await http.get(Uri.parse(request));
  //   if (response.statusCode == 200) {
  //     setState(() {
  //       _placeList = json.decode(response.body)['predictions'];
  //     });
  //   } else {
  //     throw Exception('Failed to load predictions');
  //   }
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
          title: const Text('Рестораны рядом',
              style: TextStyle(color: Colors.black)),
        ),
        body: Consumer(builder: (context, LocationProvider provider, _) {
          if (provider.status == LocationProviderStatus.Loading ||
              provider.status == LocationProviderStatus.Initial) {
            return Center(child: CircularProgressIndicator());
          } else if (provider.status == LocationProviderStatus.Success) {
            var locationProvider = Provider.of<UserLocation>(context);

            if (_markers.isEmpty) {
              _showNearbyRestaurants(
                  locationProvider.latitude, locationProvider.longitude);
            }
            return Column(children: [
              // Container(
              //   child: Center(
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: <Widget>[
              //         Align(
              //           alignment: Alignment.topCenter,
              //           child: TextField(
              //             textAlign: TextAlign.center,
              //             controller: _controller,
              //             decoration: InputDecoration(
              //               hintText: "Найдите свой ресторан!",
              //               focusColor: Colors.white,
              //               floatingLabelBehavior: FloatingLabelBehavior.never,
              //             ),
              //           ),
              //         ),
              //         ListView.builder(
              //           physics: NeverScrollableScrollPhysics(),
              //           shrinkWrap: true,
              //           itemCount: _placeList.length,
              //           itemBuilder: (context, index) {
              //             return ListTile(
              //               title: Text(_placeList[index]["description"]),
              //             );
              //           },
              //         )
              //       ],
              //     ),
              //   ),
              // ),
              Expanded(
                child: SizedBox(
                  //height: MediaQuery.of(context).size.height - 50 - 111,
                  child: GoogleMap(
                    markers: _markers,
                    initialCameraPosition: CameraPosition(
                        zoom: 15,
                        target: LatLng(locationProvider.latitude,
                            locationProvider.longitude)),
                    myLocationEnabled: true,
                    mapToolbarEnabled: true,
                    mapType: MapType.normal,
                    myLocationButtonEnabled: true,
                    // onMapCreated: (GoogleMapController controller) {
                    //   _controller.complete(controller);
                    // },
                  ),
                ),
              ),
            ]);
          } else {
            return Center(
                child: Text("Мы не можем получить ваше местоположение :("));
          }
        }));
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
                                price: "₽₽₽",
                                description: "",
                              )))),
              position: LatLng(
                  result.geometry!.location.lat, result.geometry!.location.lng),
            ))
        .toSet();

    setState(() {
      _markers.addAll(_restaurantMarkers); //!error
    });
  }

  // void animatedViewofMap({double? lat, double? lng}) async {
  //   CameraPosition cPosition = CameraPosition(
  //     zoom: cameraZoom,
  //     target: LatLng(lat!, lng!),
  //   );
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
  // }
}
