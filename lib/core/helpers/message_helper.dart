import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../navigation/navigator.dart';
import '../shared_cubits/theme/theme_cubit.dart';

class MessageHelper {
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> _showSnackBar(
    String message, {
    Color backgroundColor = Colors.grey,
    DismissDirection dismissDirection = DismissDirection.vertical,
    Duration duration = const Duration(seconds: 2),
  }) {
    return ScaffoldMessenger.of(AppNavigator.rootContext!).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        dismissDirection: dismissDirection,
        duration: duration,
      ),
    );
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSuccessSnackBar(String message) {
    return _showSnackBar(
      message,
      backgroundColor: AppNavigator.rootContext!.read<ThemeCubit>().state.colorPalette.success,
    );
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showErrorSnackBar(String message) {
    return _showSnackBar(
      message,
      backgroundColor: AppNavigator.rootContext!.read<ThemeCubit>().state.colorPalette.error,
    );
  }

  static Future<bool?> _showToast(
    String message, {
    ToastGravity gravity = ToastGravity.BOTTOM,
    Toast length = Toast.LENGTH_SHORT,
    Color backgroundColor = Colors.grey,
    Color textColor = Colors.white,
    double fontSize = 16.0,
  }) async {
    return await Fluttertoast.showToast(
      msg: message,
      toastLength: length,
      gravity: gravity,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: fontSize,
    );
  }

  static Future<bool?> showSuccessToast(String message) async {
    return await _showToast(
      message,
      backgroundColor: AppNavigator.rootContext!.watch<ThemeCubit>().state.colorPalette.success,
    );
  }
}
