import 'package:bread_app/widgets/custom/card.dart';
import 'package:bread_app/widgets/custom/scaffold.dart';
import 'package:bread_app/widgets/custom/sized_box.dart';
import 'package:bread_app/widgets/custom/title.dart';
import 'package:bread_app/widgets/record/record_overview.dart';
import 'package:flutter/material.dart';

import 'record_new_bake_screen.dart';

class RecordBakeScreen extends StatelessWidget {
  const RecordBakeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          const CustomTitle(
            icon: Icons.bookmark_border_rounded,
            text: "Record your Bake!",
          ),
          const CustomSizedBox(),
          CustomCard(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecordNewBakeScreen(),
                ),
              );
            },
            child: const Icon(Icons.add_outlined),
          ),
          const RecordOverview()
        ],
      ),
    );
  }
}
