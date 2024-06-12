import 'package:bread_app/models/bakers_percentage_key.dart';
import 'package:bread_app/utils/shared_preferences_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/bakers_percentage_state.dart';
import '../../utils/text_field_helper.dart';
import '../custom/text_field.dart';

class BpAmountForm extends StatelessWidget {
  BpAmountForm({super.key});

  final TextEditingController _flourController = TextEditingController();
  final TextEditingController _waterController = TextEditingController();
  final TextEditingController _starterController = TextEditingController();
  final TextEditingController _saltController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var bpState = context.watch<BakersPercentageState>();
    final prefs = SpHelper();

    TextController.setController(_flourController, bpState.flourAmount);
    TextController.setController(_waterController, bpState.waterAmount);
    TextController.setController(_starterController, bpState.starterAmount);
    TextController.setController(_saltController, bpState.saltAmount);

    return Column(children: [
      CustomTextField(
        controller: _flourController,
        label: "Flour",
        unit: "g",
        onChanged: (value) {
          bpState.flourAmount = value;
          _flourController.text = bpState.flourAmount;
          prefs.saveString(BpKey().flourAmount, value);
        },
      ),
      CustomTextField(
        controller: _waterController,
        label: "Water",
        unit: "g",
        onChanged: (value) {
          bpState.waterAmount = value;
          _waterController.text = bpState.waterAmount;
          prefs.saveString(BpKey().waterAmount, value);
        },
      ),
      CustomTextField(
        controller: _starterController,
        label: "Sourdough Starter",
        unit: "g",
        onChanged: (value) {
          bpState.starterAmount = value;
          _starterController.text = bpState.starterAmount;
          prefs.saveString(BpKey().starterAmount, value);
        },
      ),
      CustomTextField(
        controller: _saltController,
        label: "Salt",
        unit: "g",
        onChanged: (value) {
          bpState.saltAmount = value;
          _saltController.text = bpState.saltAmount;
          prefs.saveString(BpKey().saltAmount, value);
        },
      ),
    ]);
  }
}
