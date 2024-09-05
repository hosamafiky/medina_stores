import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medina_stores/config/resources/locale_keys.g.dart';
import 'package:medina_stores/core/extensions/context.dart';
import 'package:medina_stores/core/extensions/sheet.dart';
import 'package:medina_stores/core/extensions/spaced_column.dart';
import 'package:medina_stores/core/navigation/navigator.dart';
import 'package:medina_stores/features/ad/presentation/presentation_imports.dart';
import 'package:medina_stores/features/brand/presentation/presentation_imports.dart';
import 'package:medina_stores/features/cart/presentation/presentation_imports.dart';

import '../../../core/helpers/dependency_helper.dart';
import '../../../core/shared_widgets/core_widgets/main_app_bar.dart';
import '../../../core/shared_widgets/core_widgets/visitor_login_sheet.dart';
import '../../category/presentation/presentation_imports.dart';

part 'cubit/main_cubit.dart';
part 'cubit/main_state.dart';
part 'pages/main_tab_page.dart';
