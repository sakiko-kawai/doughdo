import 'package:bread_app/utils/calc_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/bakers_percentage_state.dart';

class BpConvertButtons extends StatelessWidget {
  const BpConvertButtons({super.key});

  @override
  Widget build(BuildContext context) {
    var bpState = context.watch<BakersPercentageState>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            bpState.waterPercentage = CalcHelper.calcPercentage(
                bpState.flourAmount, bpState.waterAmount);
            bpState.starterPercentage = CalcHelper.calcPercentage(
                bpState.flourAmount, bpState.starterAmount);
            bpState.saltPercentage = CalcHelper.calcPercentage(
                bpState.flourAmount, bpState.saltAmount);
          },
          child: const Icon(Icons.arrow_upward),
        ),
        ElevatedButton(
          onPressed: () {
            bpState.waterAmount = CalcHelper.calcAmount(
                bpState.flourAmount, bpState.waterPercentage);
            bpState.saltAmount = CalcHelper.calcAmount(
                bpState.flourAmount, bpState.saltPercentage);
            bpState.starterAmount = CalcHelper.calcAmount(
                bpState.flourAmount, bpState.starterPercentage);
          },
          child: const Icon(Icons.arrow_downward),
        )
      ],
    );
  }
}
