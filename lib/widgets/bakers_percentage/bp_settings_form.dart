import 'package:bread_app/models/bakers_percentage_key.dart';
import 'package:bread_app/utils/shared_preferences_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/bakers_percentage_state.dart';
import '../../utils/text_field_helper.dart';
import '../custom/text_field.dart';

class BpSettingsForm extends StatelessWidget {
  BpSettingsForm({super.key});

  final TextEditingController _hydratonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var bpState = context.watch<BakersPercentageState>();
    final prefs = SpHelper();

    TextController.setController(_hydratonController, bpState.starterHydration);

    return Column(children: [
      CustomTextField(
        controller: _hydratonController,
        label: "Starter Hydration",
        unit: "%",
        onChanged: (value) {
          bpState.starterHydration = value;
          _hydratonController.text = bpState.starterHydration;
          prefs.saveString(BpKey().starterHydration, value);
        },
      ),
    ]);
  }
}
