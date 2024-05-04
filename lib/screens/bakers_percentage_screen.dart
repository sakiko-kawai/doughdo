import 'package:bread_app/models/bakers_percentage_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/bakers_percentage/bp_amount_form.dart';
import '../widgets/bakers_percentage/bp_convert_buttons.dart';
import '../widgets/bakers_percentage/bp_percentage_form.dart';
import '../widgets/bakers_percentage/bp_settings_form.dart';
import '../widgets/custom/custom_scaffold.dart';

class BakersPercentageScreen extends StatelessWidget {
  const BakersPercentageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BakersPercentageState(),
      child: CustomScaffold(
        child: Column(
          children: [
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
