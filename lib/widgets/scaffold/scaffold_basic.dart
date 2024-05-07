import 'package:bread_app/widgets/scaffold/buttom_navigation_bar.dart';
import 'package:bread_app/widgets/scaffold/scaffold_body.dart';
import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  final Widget child;

  const CustomScaffold({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CustomBottomNavigationBar(),
      body: CustomScaffoldBody(child: child),
    );
  }
}
