import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/bakers_percentage_state.dart';
import '../../utils/text_field_helper.dart';
import '../custom/custom_text_field.dart';

class BpAmountForm extends StatefulWidget {
  const BpAmountForm({super.key});

  @override
  State<BpAmountForm> createState() => _BpAmountFormState();
}

class _BpAmountFormState extends State<BpAmountForm> {
  final TextEditingController _flourController = TextEditingController();
  final TextEditingController _waterController = TextEditingController();
  final TextEditingController _starterController = TextEditingController();
  final TextEditingController _saltController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var bpState = context.watch<BakersPercentageState>();

    TextController.setController(_flourController, bpState.flourAmount);
    TextController.setController(_waterController, bpState.waterAmount);
    TextController.setController(_starterController, bpState.starterAmount);
    TextController.setController(_saltController, bpState.saltAmount);

    return Column(children: [
      const Text("Amout of Ingredients"),
      CustomTextField(
        controller: _flourController,
        label: "Flour",
        unit: "g",
        onChanged: (value) {
          bpState.flourAmount = value;
          _flourController.text = bpState.flourAmount;
        },
      ),
      CustomTextField(
        controller: _waterController,
        label: "Water",
        unit: "g",
        onChanged: (value) {
          bpState.waterAmount = value;
          _waterController.text = bpState.waterAmount;
        },
      ),
      CustomTextField(
        controller: _starterController,
        label: "Sourdough Starter",
        unit: "g",
        onChanged: (value) {
          bpState.starterAmount = value;
          _starterController.text = bpState.starterAmount;
        },
      ),
      CustomTextField(
        controller: _saltController,
        label: "Salt",
        unit: "g",
        onChanged: (value) {
          bpState.saltAmount = value;
          _saltController.text = bpState.saltAmount;
        },
      ),
    ]);
  }
}
