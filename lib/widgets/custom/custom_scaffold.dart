import 'package:flutter/material.dart';

import '../../screens/bakers_percentage_screen.dart';
import '../../screens/record_bake_screen.dart';
import '../../screens/save_tips_screen.dart';

class CustomScaffold extends StatelessWidget {
  final Widget child;

  const CustomScaffold({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              enableFeedback: false,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BakersPercentageScreen(),
                  ),
                );
              },
              icon: const Icon(
                Icons.calculate_outlined,
                color: Colors.white,
              ),
            ),
            IconButton(
              enableFeedback: false,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RecordBakeScreen(),
                  ),
                );
              },
              icon: const Icon(
                Icons.notes_outlined,
                color: Colors.white,
              ),
            ),
            IconButton(
              enableFeedback: false,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SaveTipsScreen(),
                  ),
                );
              },
              icon: const Icon(
                Icons.widgets_outlined,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: ListView(
          children: [
            SafeArea(
              minimum: const EdgeInsets.all(20),
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
