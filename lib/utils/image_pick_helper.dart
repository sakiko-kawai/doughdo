import 'package:image_picker/image_picker.dart';

class ImagePickHelper {
  final ImagePicker _picker = ImagePicker();

  Future<XFile?> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    return pickedFile;
  }
}
