import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/bakers_percentage_state.dart';

class BpPercentageForm extends StatelessWidget {
  const BpPercentageForm({super.key});

  @override
  Widget build(BuildContext context) {
    var bpState = context.watch<BakersPercentageState>();

    return Column(children: [
      TextField(
        decoration: const InputDecoration(
          labelText: "Flour (g)",
        ),
        onChanged: (value) {
          bpState.flourAmount = double.parse(value);
        },
      ),
      TextField(
        decoration: const InputDecoration(
          labelText: "Water (%)",
        ),
        onChanged: (value) {
          bpState.waterPercentage = double.parse(value);
        },
      ),
      TextField(
        decoration: const InputDecoration(
          labelText: "Sourdough Starter (%)",
        ),
        onChanged: (value) {
          bpState.starterPercentage = double.parse(value);
        },
      ),
      TextField(
        decoration: const InputDecoration(
          labelText: "Salt (%)",
        ),
        onChanged: (value) {
          bpState.saltPercentage = double.parse(value);
        },
      ),
    ]);
  }
}
