import 'package:flutter/material.dart';

class CustomScaffoldBody extends StatelessWidget {
  final Widget child;

  const CustomScaffoldBody({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
    );
  }
}
