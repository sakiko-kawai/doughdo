import 'package:bread_app/widgets/custom/buttom_navigation_bar.dart';
import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  final Widget child;
  final bool showBackButton;
  final void Function()? onTapBackButton;

  const CustomScaffold(
      {super.key,
      required this.child,
      this.showBackButton = false,
      this.onTapBackButton});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CustomBottomNavigationBar(),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SafeArea(
          minimum: const EdgeInsets.all(20),
          child: Stack(
            children: [
              Positioned.fill(child: ListView(children: [child])),
              if (showBackButton)
                Positioned(
                  top: 0,
                  left: 0,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: onTapBackButton,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
