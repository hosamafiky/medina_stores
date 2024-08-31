import 'dart:io';

import 'package:file_picker/file_picker.dart';

class FilePickerHelper {
  static Future<File?> pickFile() async {
    final result = await FilePicker.platform.pickFiles(withData: true);

    if (result != null) {
      return File(result.files.single.path!);
    }
    return null;
  }

  static Future<List<File>?> pickFiles() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      withData: true,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc'],
    );

    if (result != null) {
      return result.files.map((e) => File(e.path!)).toList();
    }
    return null;
  }
}
