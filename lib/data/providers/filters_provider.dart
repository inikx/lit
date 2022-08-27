import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class FiltersProvider extends ChangeNotifier {
  List _selectedKitchens = [];
  List get selectedKitchens => _selectedKitchens;

  SfRangeValues _price = SfRangeValues(0.0, 3000.0);
  SfRangeValues get price => _price;
  int get lowPrice => _price.start.toInt();
  int get maxPrice => _price.end.toInt();

  double _rating = 1.0;
  double get rating => _rating;

  String _sort = 'С наибольшим рейтингом';
  String get sort => _sort;

  void changeSelectedKitchens(newSelectedKitchens) {
    _selectedKitchens = newSelectedKitchens;
    notifyListeners();
  }

  void changePrice(newPrice) {
    _price = newPrice;
    notifyListeners();
  }

  void changeRating(newRating) {
    _rating = newRating;
    notifyListeners();
  }

  void changeSort(newSort) {
    _sort = newSort;
    notifyListeners();
  }
}
