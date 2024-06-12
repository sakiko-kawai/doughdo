import 'package:bread_app/models/bakers_percentage_key.dart';
import 'package:bread_app/utils/calc_helper.dart';
import 'package:bread_app/utils/shared_preferences_helper.dart';
import 'package:bread_app/widgets/custom/sized_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/bakers_percentage_state.dart';

class BpConvertButtons extends StatelessWidget {
  const BpConvertButtons({super.key});

  @override
  Widget build(BuildContext context) {
    var bpState = context.watch<BakersPercentageState>();
    final prefs = SpHelper();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton.icon(
          onPressed: () {
            bpState.starterAmount = CalcHelper.calcAmount(
                bpState.flourAmount, bpState.starterPercentage);
            bpState.waterAmount = CalcHelper.calcWaterAmount(
                bpState.flourAmount,
                bpState.waterPercentage,
                bpState.starterAmount,
                bpState.starterHydration);
            bpState.saltAmount = CalcHelper.calcAmount(
                bpState.flourAmount, bpState.saltPercentage);

            prefs.saveString(BpKey().starterAmount, bpState.starterAmount);
            prefs.saveString(BpKey().waterAmount, bpState.waterAmount);
            prefs.saveString(BpKey().saltAmount, bpState.saltAmount);
          },
          icon: const Icon(Icons.arrow_downward),
          label: const Text("Calculate Amount of Ingredients"),
        ),
        const CustomSizedBox(),
        ElevatedButton.icon(
          onPressed: () {
            bpState.waterPercentage = CalcHelper.calcWaterPercentage(
                bpState.flourAmount,
                bpState.waterAmount,
                bpState.starterAmount,
                bpState.starterHydration);
            bpState.starterPercentage = CalcHelper.calcPercentage(
                bpState.flourAmount, bpState.starterAmount);
            bpState.saltPercentage = CalcHelper.calcPercentage(
                bpState.flourAmount, bpState.saltAmount);

            prefs.saveString(BpKey().waterPercentage, bpState.starterAmount);
            prefs.saveString(
                BpKey().starterPercentage, bpState.starterPercentage);
            prefs.saveString(BpKey().saltPercentage, bpState.saltPercentage);
          },
          icon: const Icon(Icons.arrow_upward),
          label: const Text("Calculate Baker's Percentage"),
        ),
        const CustomSizedBox(),
      ],
    );
  }
}
