import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lit/data/provider/location_provider.dart';
import 'package:lit/presentation/pages/booking_status.dart';
import 'package:lit/presentation/pages/login.dart';
import 'package:lit/presentation/pages/map.dart';
import 'package:lit/presentation/pages/restaurants.dart';
import 'package:lit/presentation/pages/profile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lit/presentation/pages/selections.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:lit/constants/locator.dart';
import 'package:lit/route.dart';

void main() async {
  await setupLocator();
  ChangeNotifierProvider(
    create: (context) => LocationProvider(),
    child: LitApp(router: AppRouter()),
  );
}

class LitApp extends StatelessWidget {
  final AppRouter router;
  const LitApp({Key? key, required this.router}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/auth",
      onGenerateRoute: router.generateRoute,
      title: "Lit",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(textTheme: GoogleFonts.montserratTextTheme()),
      home: const MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    RestaurantsPage(),
    Maps(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 1) {
        var provider = Provider.of<LocationProvider>(context, listen: false);
        provider.getLocation();
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedItemColor: Colors.black87,
            unselectedItemColor: Colors.black45,
            iconSize: 35,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                label: "Рестораны",
                icon: Icon(Icons.restaurant_outlined),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.map),
                label: 'Карта',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Профиль',
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        ));
  }
}
