import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/resources/locale_keys.g.dart';
import '../../../core/extensions/context.dart';
import '../../../core/extensions/spaced_row.dart';
import '../../../core/extensions/string.dart';
import '../../../core/helpers/cache_helper.dart';
import '../../../core/helpers/message_helper.dart';
import '../../../core/navigation/navigator.dart';
import '../../../core/shared_widgets/core_widgets/main_app_bar.dart';
import '../../../core/shared_widgets/state_managers/loading_manager.dart';
import '../../../core/standards/usecase_status.dart';
import '../../user/domain/domain_imports.dart';
import '../../user/presentation/presentation_imports.dart';

part 'pages/me_tab.dart';
part 'widgets/me_page_listener.dart';
