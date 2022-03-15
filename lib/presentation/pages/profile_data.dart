import 'package:flutter/material.dart';

class ProfileDataPage extends StatelessWidget {
  const ProfileDataPage({Key? key}) : super(key: key);

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
          "Мои данные",
          style: TextStyle(color: Colors.black),
          textAlign: TextAlign.center,
        ),
      ),
      body: Column(), //
    );
  }
}
