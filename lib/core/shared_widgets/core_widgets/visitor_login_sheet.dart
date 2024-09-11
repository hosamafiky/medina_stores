import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/resources/color_palettes/color_palette.dart';
import '../../../config/resources/locale_keys.g.dart';
import '../../../features/user/presentation/presentation_imports.dart';
import '../../extensions/context.dart';
import '../../navigation/navigator.dart';

class VisitorLoginSheet extends StatelessWidget {
  const VisitorLoginSheet({super.key, required this.onLoggedInCallback});

  final VoidCallback onLoggedInCallback;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: REdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            children: [
              const Align(
                alignment: AlignmentDirectional.centerStart,
                child: InkWell(
                  onTap: AppNavigator.pop,
                  child: Icon(Icons.close),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 75.w),
                child: Icon(Icons.warning_amber_rounded, size: 100.w, color: context.colorPalette.error),
              ),
              SizedBox(height: 20.h),
              Text(
                context.tr(LocaleKeys.you_must_be_logged_in_first),
                style: context.appTextStyle.elevatedButtonTextStyle,
              ),
            ],
          ),
        ),
        Container(
          padding: REdgeInsets.all(16).copyWith(
            bottom: context.bottomBarHeight + 16.h,
          ),
          color: ColorPalette.whiteColor,
          child: ElevatedButton(
            onPressed: () async {
              AppNavigator.pop();
              final isLoggedIn = await AppNavigator.to(const LoginPage(isContinue: true));
              if (isLoggedIn == true) onLoggedInCallback.call();
            },
            child: Text(LocaleKeys.login.tr()),
          ),
        ),
      ],
    );
  }
}
