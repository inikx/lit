import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lit/data/provider/location_provider.dart';
import 'package:lit/presentation/pages/map.dart';
import 'package:lit/presentation/pages/profile.dart';
import 'package:lit/presentation/widgets/bottom_sheets/restaurants_filters_bottom_sheet.dart';
import 'package:lit/presentation/widgets/restaurants_list.dart';
import 'package:provider/provider.dart';

class RestaurantsPage extends StatelessWidget {
  const RestaurantsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<LocationProvider>(context, listen: true);
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
                  })
            ]),
        body: SafeArea(
          child: Column(children: [
            Expanded(
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: const RestaurantsList()),
            ),
          ]),
        ));
  }
}
