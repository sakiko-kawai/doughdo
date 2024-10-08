import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final void Function()? onTap;
  const CustomCard({super.key, required this.child, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card.outlined(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: SizedBox(
            width: 300,
            height: 100,
            child: Center(child: child),
          ),
        ),
      ),
    );
  }
}
