import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class Map extends StatelessWidget {
  const Map({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const YandexMap();
  }
}
