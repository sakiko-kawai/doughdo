import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ImageHelper {
  Future<String> saveImage(XFile image) async {
    final dir = await getApplicationDocumentsDirectory();
    final savedImagePath = "${dir.path}\\${image.name}";
    final File file = File(image.path);
    await file.copy(savedImagePath);

    return savedImagePath;
  }
}
