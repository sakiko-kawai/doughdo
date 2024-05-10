import 'package:flutter/material.dart';

class CustomTitle extends StatelessWidget {
  final IconData? icon;
  final String text;

  const CustomTitle({
    Key? key,
    this.icon,
    required this.text,
  }) : super(key: key);

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
