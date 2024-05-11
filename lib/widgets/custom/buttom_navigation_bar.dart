import 'package:bread_app/screens/bakers_percentage_screen.dart';
import 'package:bread_app/screens/record/record_overview_screen.dart';
import 'package:bread_app/screens/save_tips_screen.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
              Icons.calculate_rounded,
              color: Colors.white,
            ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RecordOverviewScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.bookmark_rounded,
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
    );
  }
}
