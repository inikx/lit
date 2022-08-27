import 'package:flutter/material.dart';
import 'package:lit/presentation/pages/profile.dart';
import 'package:lit/presentation/pages/restaurants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _page = 0;
  PageController _pageController = PageController();

  @override
  void initState() {
    _pageController = PageController(initialPage: _page);
    super.initState();
  }

  void _onTappedBar(int value) {
    setState(() {
      _page = value;
      _pageController.jumpToPage(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: PageView(
            physics: const BouncingScrollPhysics(),
            controller: _pageController,
            onPageChanged: (currentPage) {
              setState(() {
                _page = currentPage;
              });
            },
            children: [RestaurantsPage(), ProfilePage()]),
        bottomNavigationBar: Theme(
            data: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.134,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  boxShadow: kElevationToShadow[4]),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                child: BottomNavigationBar(
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  selectedItemColor: Colors.black87,
                  unselectedItemColor: Colors.black45,
                  selectedIconTheme: IconThemeData(size: 35),
                  unselectedIconTheme: IconThemeData(
                    size: 30,
                  ),
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      label: "Рестораны",
                      icon: Icon(Icons.restaurant_outlined),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person),
                      label: 'Профиль',
                    ),
                  ],
                  currentIndex: _page,
                  onTap: _onTappedBar,
                ),
              ),
            )));
  }
}
