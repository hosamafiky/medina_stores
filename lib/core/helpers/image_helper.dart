import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../config/resources/color_palettes/color_palette.dart';
import '../../config/resources/locale_keys.g.dart';
import '../navigation/navigator.dart';

class ImageHelper {
  static final ImagePicker _picker = ImagePicker();
  static final ImageCropper _cropper = ImageCropper();

  static Future<File?> takePicture() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image == null) return null;
    return await _cropImage(sourcePath: image.path);
  }

  static Future<File?> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;
    return await _cropImage(sourcePath: image.path);
  }

  static Future<List<File>> pickImages() async {
    final images = await _picker.pickMultiImage();
    return images.map((e) => File(e.path)).toList();
  }

  static Future<File?> _cropImage({required String sourcePath}) async {
    CroppedFile? croppedFile = await _cropper.cropImage(
      sourcePath: sourcePath,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: ColorPalette.whiteColor,
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
            CropAspectRatioPresetCustom(),
          ],
        ),
        IOSUiSettings(
          title: 'Cropper',
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
            CropAspectRatioPresetCustom(),
          ],
        ),
      ],
    );
    return croppedFile != null ? File(croppedFile.path) : null;
  }

  static Future<File?> showImagePicker(GlobalKey key) async {
    if (Platform.isIOS) {
      return await _showIOSSheet(key.currentContext!);
    }
    return await _showAndroidMenuPopup(key);
  }

  static Future<List<File>> showImagesPicker() async {
    final images = await pickImages();
    List<File> croppedImages = [];
    for (var image in images) {
      final cropped = await _cropImage(sourcePath: image.path);
      if (cropped == null) continue;
      croppedImages.add(cropped);
    }

    return croppedImages;
  }

  static Future<File?> _showIOSSheet(BuildContext context) async {
    return await showCupertinoModalPopup<File?>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Select Image Source'),
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: Text(LocaleKeys.camera.tr()),
            onPressed: () async {
              final image = await takePicture();
              AppNavigator.pop(image);
            },
          ),
          CupertinoActionSheetAction(
            child: Text(LocaleKeys.photo_library.tr()),
            onPressed: () async {
              final image = await pickImage();
              AppNavigator.pop(image);
            },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: AppNavigator.pop,
          child: Text(LocaleKeys.cancel.tr()),
        ),
      ),
    );
  }

  static Future<File?> _showAndroidMenuPopup(GlobalKey key) async {
    final RenderBox renderBox = key.currentContext!.findRenderObject() as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);
    final value = await showMenu<String?>(
      context: key.currentContext!,
      color: ColorPalette.whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      position: RelativeRect.fromLTRB(
        offset.dx - renderBox.size.width / 2,
        offset.dy + renderBox.size.height + 10,
        offset.dx + renderBox.size.width / 2,
        offset.dy + renderBox.size.height,
      ),
      items: [
        PopupMenuItem(
          value: 'camera',
          child: ListTile(
            // leading: SvgManager.camera_menu.svg(),
            visualDensity: VisualDensity.compact,
            title: Text(LocaleKeys.camera.tr()),
          ),
        ),
        PopupMenuItem(
          value: 'photo_library',
          child: ListTile(
            // leading: SvgManager.gallery_menu.svg(),
            visualDensity: VisualDensity.compact,
            title: Text(LocaleKeys.photo_library.tr()),
          ),
        ),
      ],
    );

    if (value == 'camera') {
      return await takePicture();
    } else if (value == 'photo_library') {
      return await pickImage();
    } else {
      return null;
    }
  }
}

class CropAspectRatioPresetCustom implements CropAspectRatioPresetData {
  @override
  (int, int)? get data => (324, 214);

  @override
  String get name => '324 x 214 (3:2) Customized';
}
