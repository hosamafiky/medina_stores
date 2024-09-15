import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medina_stores/features/language/presentation/presentation_imports.dart';
import 'package:medina_stores/features/product/presentation/presentation_imports.dart';

import '../../../config/resources/locale_keys.g.dart';
import '../../../core/extensions/context.dart';
import '../../../core/extensions/spaced_row.dart';
import '../../../core/navigation/navigator.dart';
import '../../../core/shared_widgets/core_widgets/main_app_bar.dart';
import '../../address/presentation/presentation_imports.dart';
import '../../static_page/presentation/presentation_imports.dart';
import '../../user/domain/domain_imports.dart';
import '../../user/presentation/presentation_imports.dart';

part 'pages/me_tab.dart';
part 'widgets/account_section.dart';
part 'widgets/help_section.dart';
