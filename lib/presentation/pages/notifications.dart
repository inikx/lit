import 'package:flutter/material.dart';

class ProfileNotificationsPage extends StatelessWidget {
  const ProfileNotificationsPage({Key? key}) : super(key: key);

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
          "Уведомления",
          style: TextStyle(color: Colors.black),
          textAlign: TextAlign.center,
        ),
      ),
      body: Column(), //
    );
  }
}
