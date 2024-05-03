import 'package:flutter/widgets.dart';

class BakersPercentageState extends ChangeNotifier {
  String _waterPercentage = "70";
  set waterPercentage(String waterPercentage) {
    _waterPercentage = waterPercentage;
    notifyListeners();
  }

  String get waterPercentage => _waterPercentage;

  String _starterPercentage = "10";
  set starterPercentage(String starterPercentage) {
    _starterPercentage = starterPercentage;
    notifyListeners();
  }

  String get starterPercentage => _starterPercentage;

  String _saltPercentage = "2";
  set saltPercentage(String saltPercentage) {
    _saltPercentage = saltPercentage;
    notifyListeners();
  }

  String get saltPercentage => _saltPercentage;

  String _flourAmount = "500";
  set flourAmount(String flourAmount) {
    _flourAmount = flourAmount;
    notifyListeners();
  }

  String get flourAmount => _flourAmount;

  String _waterAmount = "350";
  set waterAmount(String waterAmount) {
    _waterAmount = waterAmount;
    notifyListeners();
  }

  String get waterAmount => _waterAmount;

  String _starterAmount = "50";
  set starterAmount(String starterAmount) {
    _starterAmount = starterAmount;
    notifyListeners();
  }

  String get starterAmount => _starterAmount;

  String _saltAmount = "10";
  set saltAmount(String saltAmount) {
    _saltAmount = saltAmount;
    notifyListeners();
  }

  String get saltAmount => _saltAmount;
}
