import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

Future<File?> pickImage({required ImageSource source}) async {
  try {
    // ✅ على iOS Simulator، استخدم Gallery بدل Camera تلقائيًا
    ImageSource finalSource = source;

    if (!kIsWeb &&
        Platform.isIOS &&
        source == ImageSource.camera &&
        Platform.environment.containsKey("SIMULATOR_DEVICE_NAME")) {
      debugPrint(
          '⚠️ Camera not available on iOS Simulator. Using Gallery instead.');
      finalSource = ImageSource.gallery;
    }

    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: finalSource);

    if (pickedFile != null) {
      return File(pickedFile.path);
    }

    return null;
  } catch (e) {
    debugPrint('❌ Error picking image: $e');
    return null;
  }
}
