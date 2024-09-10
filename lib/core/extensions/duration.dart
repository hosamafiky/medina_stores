import 'package:easy_localization/easy_localization.dart';

import '../navigation/navigator.dart';
import 'string.dart';

extension TimeFormat on Duration {
  String get formatTime {
    final minutes = inMinutes.remainder(60).toString().localized.padLeft(2, '0'.localized);
    final seconds = inSeconds.remainder(60).toString().localized.padLeft(2, '0'.localized);

    final language = AppNavigator.rootContext!.locale.languageCode;
    return language == 'en' ? '$minutes : $seconds' : '$seconds : $minutes';
  }
}
