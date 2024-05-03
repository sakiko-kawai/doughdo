import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String unit;
  void Function(String)? onChanged;

  CustomTextField(
      {Key? key,
      required this.controller,
      required this.label,
      required this.unit,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: '$label ($unit)',
            suffix: Text(unit),
            counterText: "",
          ),
          onChanged: onChanged,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9.\b]')),
          ],
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          maxLength: 6,
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
