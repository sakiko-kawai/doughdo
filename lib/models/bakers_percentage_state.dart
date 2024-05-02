import 'package:flutter/widgets.dart';

class BakersPercentageState extends ChangeNotifier {
  double _waterPercentage = 0;
  set waterPercentage(double waterPercentage) {
    _waterPercentage = waterPercentage;
    notifyListeners();
  }

  double get waterPercentage => _waterPercentage;

  double _starterPercentage = 0;
  set starterPercentage(double starterPercentage) {
    _starterPercentage = starterPercentage;
    notifyListeners();
  }

  double get starterPercentage => _starterPercentage;

  double _saltPercentage = 0;
  set saltPercentage(double saltPercentage) {
    _saltPercentage = saltPercentage;
    notifyListeners();
  }

  double get saltPercentage => _saltPercentage;

  double _flourAmount = 0;
  set flourAmount(double flourAmount) {
    _flourAmount = flourAmount;
    notifyListeners();
  }

  double get flourAmount => _flourAmount;
}

class BakersPercentageModelHaha {
  double waterPercentage = 0;
  double starterPercentage = 0;
  double saltPercentage = 0;

  double flourAmount = 0;
  double waterAmount = 0;
  double starterAmount = 0;
  double saltAmount = 0;
}
