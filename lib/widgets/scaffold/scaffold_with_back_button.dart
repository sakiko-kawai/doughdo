import 'package:bread_app/widgets/scaffold/buttom_navigation_bar.dart';
import 'package:bread_app/widgets/scaffold/scaffold_body.dart';
import 'package:flutter/material.dart';

class CustomScaffoldBackButton extends StatelessWidget {
  final Widget child;

  const CustomScaffoldBackButton({Key? key, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leadingWidth: 50,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
      body: CustomScaffoldBody(child: child),
    );
  }
}
