import 'package:bread_app/models/bakers_percentage_state.dart';
import 'package:bread_app/widgets/custom/sized_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/bakers_percentage/bp_amount_form.dart';
import '../widgets/bakers_percentage/bp_convert_buttons.dart';
import '../widgets/bakers_percentage/bp_percentage_form.dart';
import '../widgets/bakers_percentage/bp_settings_form.dart';
import '../widgets/scaffold/scaffold_basic.dart';
import '../widgets/custom/title.dart';

class BakersPercentageScreen extends StatelessWidget {
  const BakersPercentageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BakersPercentageState(),
      child: CustomScaffold(
        child: Column(
          children: [
            const CustomTitle(
              icon: Icons.bakery_dining_rounded,
              text: "Calculate your Bake!",
            ),
            const CustomSizedBox(),
            BpSettingsForm(),
            BpPercentageForm(),
            const BpConvertButtons(),
            BpAmountForm(),
          ],
        ),
      ),
    );
  }
}
