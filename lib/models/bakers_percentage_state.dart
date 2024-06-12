import 'package:bread_app/models/bakers_percentage_key.dart';
import 'package:bread_app/utils/shared_preferences_helper.dart';
import 'package:flutter/widgets.dart';

class BakersPercentageState extends ChangeNotifier {
  String _starterHydration = SpHelper().getString(BpKey().starterHydration);
  set starterHydration(String starterHydration) {
    _starterHydration = starterHydration;
    notifyListeners();
  }

  String get starterHydration => _starterHydration;

  String _waterPercentage = SpHelper().getString(BpKey().waterPercentage);
  set waterPercentage(String waterPercentage) {
    _waterPercentage = waterPercentage;
    notifyListeners();
  }

  String get waterPercentage => _waterPercentage;

  String _starterPercentage = SpHelper().getString(BpKey().starterPercentage);
  set starterPercentage(String starterPercentage) {
    _starterPercentage = starterPercentage;
    notifyListeners();
  }

  String get starterPercentage => _starterPercentage;

  String _saltPercentage = SpHelper().getString(BpKey().saltPercentage);
  set saltPercentage(String saltPercentage) {
    _saltPercentage = saltPercentage;
    notifyListeners();
  }

  String get saltPercentage => _saltPercentage;

  String _flourAmount = SpHelper().getString(BpKey().flourAmount);
  set flourAmount(String flourAmount) {
    _flourAmount = flourAmount;
    notifyListeners();
  }

  String get flourAmount => _flourAmount;

  String _waterAmount = SpHelper().getString(BpKey().waterAmount);
  set waterAmount(String waterAmount) {
    _waterAmount = waterAmount;
    notifyListeners();
  }

  String get waterAmount => _waterAmount;

  String _starterAmount = SpHelper().getString(BpKey().starterAmount);
  set starterAmount(String starterAmount) {
    _starterAmount = starterAmount;
    notifyListeners();
  }

  String get starterAmount => _starterAmount;

  String _saltAmount = SpHelper().getString(BpKey().saltAmount);
  set saltAmount(String saltAmount) {
    _saltAmount = saltAmount;
    notifyListeners();
  }

  String get saltAmount => _saltAmount;
}
