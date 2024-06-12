import 'package:bread_app/models/bakers_percentage_key.dart';
import 'package:bread_app/utils/shared_preferences_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/bakers_percentage_state.dart';
import '../../utils/text_field_helper.dart';
import '../custom/text_field.dart';

class BpPercentageForm extends StatelessWidget {
  BpPercentageForm({super.key});

  final TextEditingController _flourController = TextEditingController();
  final TextEditingController _waterController = TextEditingController();
  final TextEditingController _starterController = TextEditingController();
  final TextEditingController _saltController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var bpState = context.watch<BakersPercentageState>();
    final prefs = SpHelper();

    TextController.setController(_flourController, bpState.flourAmount);
    TextController.setController(_waterController, bpState.waterPercentage);
    TextController.setController(_starterController, bpState.starterPercentage);
    TextController.setController(_saltController, bpState.saltPercentage);

    return Column(children: [
      const Text(
        "Baker's Percentage",
        style: TextStyle(fontSize: 18),
      ),
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
        unit: "%",
        onChanged: (value) {
          bpState.waterPercentage = value;
          _waterController.text = bpState.waterPercentage;
          prefs.saveString(BpKey().waterPercentage, value);
        },
      ),
      CustomTextField(
        controller: _starterController,
        label: "Sourdough Starter",
        unit: "%",
        onChanged: (value) {
          bpState.starterPercentage = value;
          _starterController.text = bpState.starterPercentage;
          prefs.saveString(BpKey().starterPercentage, value);
        },
      ),
      CustomTextField(
        controller: _saltController,
        label: "Salt",
        unit: "%",
        onChanged: (value) {
          bpState.saltPercentage = value;
          _saltController.text = bpState.saltPercentage;
          prefs.saveString(BpKey().saltPercentage, value);
        },
      ),
    ]);
  }
}
