import 'package:flutter/material.dart';
import 'package:lit/presentation/pages/booking_status.dart';
import 'package:lit/presentation/pages/login.dart';
import 'package:lit/presentation/pages/restaurants.dart';
import 'package:lit/presentation/pages/profile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lit/presentation/widgets/geoposition.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Lit';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        //fix unfocus textfields
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: MaterialApp(
          title: _title,
          theme: ThemeData(textTheme: GoogleFonts.montserratTextTheme()),
          home: MyStatefulWidget(),
        ));
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Restaurants(),
    Geo(),
    BookingStatus(),
    Text(
      'Карта',
    ),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        iconSize: 35,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: "Рестораныы",
            icon: Icon(Icons.restaurant),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wb_incandescent),
            label: 'Подборки',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.free_breakfast),
            label: 'Статус бронирования',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Карта',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Профиль',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
