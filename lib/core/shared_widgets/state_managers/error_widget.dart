import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medina_stores/core/error/failures.dart';
import 'package:medina_stores/core/extensions/context.dart';
import 'package:medina_stores/core/extensions/spaced_column.dart';

class ErrorViewWidget extends StatelessWidget {
  const ErrorViewWidget(
    this.failure, {
    super.key,
    required this.onRetry,
  });

  final Failure failure;
  final Function()? onRetry;

  String get errorMessage {
    if (failure is UnknownFailure) return 'Unknown Error : please contact support';
    return failure.response.message;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error, color: Colors.red, size: 48),
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: context.appTextStyle.errorStyle,
          ),
          IconButton(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ).withSpacing(spacing: 16.h),
    );
  }
}
