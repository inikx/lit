import 'package:flutter/material.dart';

class ProfileFavoritesPage extends StatelessWidget {
  const ProfileFavoritesPage({Key? key}) : super(key: key);

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
        title: const Text(
          "Избранное",
          style: TextStyle(color: Colors.black),
          textAlign: TextAlign.center,
        ),
      ),
      body: Column(), //
    );
  }
}
