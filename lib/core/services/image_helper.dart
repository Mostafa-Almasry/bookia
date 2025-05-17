// import 'package:image_picker/image_picker.dart';

// class ImageHelper {
//   static Future<String?> pickImage(bool isCamera) async {
//     XFile? pickedImage = await ImagePicker().pickImage(
//       source: isCamera ? ImageSource.camera : ImageSource.gallery,
//     );
//     return pickedImage?.path;
//   }
// }

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageHelper {
  static final ImagePicker _picker = ImagePicker();

  bool fromCamera = false;
  static Future<String?> pickImage({fromCamera}) async {
    try {
      final XFile? file = await _picker.pickImage(
        source: fromCamera ? ImageSource.camera : ImageSource.gallery,
      );
      return file?.path;
    } catch (e) {
      debugPrint('Image Picker error $e');
      return null;
    }
  }
}
