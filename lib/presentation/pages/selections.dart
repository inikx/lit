import 'package:flutter/material.dart';

class SelectionsPage extends StatelessWidget {
  const SelectionsPage({Key? key}) : super(key: key);

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
        title: const Text('Подборки', style: TextStyle(color: Colors.black)),
      ),
    );
  }
}
