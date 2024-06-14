import 'package:bread_app/utils/image_helper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class LoadImage extends StatelessWidget {
  final String path;
  final double size;
  const LoadImage({super.key, required this.path, required this.size});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: ImageHelper().getImageUrl(path),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            snapshot.hasError) {
          return SizedBox(
            width: size,
            height: size,
          );
        } else if (snapshot.data == null) {
          return SizedBox(
            width: size,
            height: size,
          );
        } else {
          return CachedNetworkImage(
            imageUrl: snapshot.data!,
            height: size,
            fit: BoxFit.fill,
          );
        }
      },
    );
  }
}
