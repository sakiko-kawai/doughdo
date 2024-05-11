import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'sized_box.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String unit;
  final void Function(String)? onChanged;

  const CustomTextField(
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
        SizedBox(
          width: 300,
          child: TextField(
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
            keyboardType: TextInputType.number,
          ),
        ),
        const CustomSizedBox(),
      ],
    );
  }
}
