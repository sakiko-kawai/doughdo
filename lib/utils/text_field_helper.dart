import 'package:flutter/material.dart';

class TextController {
  static setController(TextEditingController controller, String? txt) {
    if (txt != null) {
      controller.value = TextEditingValue(
        text: txt,
        selection: TextSelection.collapsed(offset: txt.length),
      );
    }
  }
}
