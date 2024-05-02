import 'package:bread_app/models/bakers_percentage_state.dart';
import 'package:bread_app/widgets/bp_amount_form.dart';
import 'package:bread_app/widgets/bp_percentage_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BakersPercentageScreen extends StatelessWidget {
  const BakersPercentageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BakersPercentageState(),
      child: const Scaffold(
        body: Column(
          children: [
            BpPercentageForm(),
            BpAmountForm(),
          ],
        ),
      ),
    );
  }
}
