import 'package:flutter/material.dart';

enum UsecaseStatus {
  // The usecase is not running
  idle,

  // The usecase is running
  running,

  // The usecase has completed successfully
  completed,

  // The usecase has completed with an error
  error,
}

extension UsecaseStatusX on UsecaseStatus {
  Widget when<T>(
    BuildContext context, {
    WidgetBuilder? idle,
    required WidgetBuilder running,
    required WidgetBuilder completed,
    WidgetBuilder? error,
  }) {
    switch (this) {
      case UsecaseStatus.idle:
        return idle?.call(context) ?? Container();
      case UsecaseStatus.running:
        return running(context);
      case UsecaseStatus.completed:
        return completed(context);
      case UsecaseStatus.error:
        return error?.call(context) ?? Container();
    }
  }
}
