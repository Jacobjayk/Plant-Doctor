import 'dart:io';
import 'package:flutter/services.dart';

class ImageUtils {
  /// Saves an image from assets to a temporary file for testing
  static Future<String> saveAssetImageToTemp(String assetPath) async {
    final byteData = await rootBundle.load(assetPath);
    final tempDir = Directory.systemTemp;
    final file = File('${tempDir.path}/temp_image.jpg');
    await file.writeAsBytes(byteData.buffer.asUint8List());
    return file.path;
  }

  /// Validates if an image file exists and is readable
  static Future<bool> validateImageFile(String imagePath) async {
    try {
      final file = File(imagePath);
      return await file.exists();
    } catch (e) {
      return false;
    }
  }

  /// Gets the file size of an image
  static Future<int> getImageFileSize(String imagePath) async {
    try {
      final file = File(imagePath);
      return await file.length();
    } catch (e) {
      return 0;
    }
  }

  /// Deletes a temporary image file
  static Future<void> deleteTempImage(String imagePath) async {
    try {
      final file = File(imagePath);
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      print('Error deleting temp image: $e');
    }
  }
}

