import 'package:bread_app/widgets/custom/sized_box.dart';
import 'package:flutter/material.dart';

class EditImage extends StatelessWidget {
  final void Function()? onDelete;
  final Widget imageWidget;

  const EditImage({super.key, required this.onDelete, required this.imageWidget});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Stack(
        alignment: Alignment.center,
        children: [
          imageWidget,
          Container(
            width: 150,
            height: 150,
            color: Colors.black.withOpacity(0.1),
          ),
          IconButton(
            onPressed: onDelete,
            icon: const Icon(
              Icons.delete_outline_rounded,
              color: Colors.white,
            ),
          ),
        ],
      ),
      const CustomSizedBox(),
    ]);
  }
}
