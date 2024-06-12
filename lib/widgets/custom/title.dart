import 'package:flutter/material.dart';

class CustomTitle extends StatelessWidget {
  final IconData? icon;
  final String text;

  const CustomTitle({
    super.key,
    this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon),
        Text(
          text,
          style: const TextStyle(fontSize: 22),
        ),
        Icon(icon),
      ],
    );
  }
}
