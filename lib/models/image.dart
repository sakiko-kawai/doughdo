import 'package:image/image.dart';
import 'package:image_picker/image_picker.dart';

class CustomImage {
  final XFile? pickedImage;
  final Image? image;

  CustomImage({this.pickedImage, this.image});
}
