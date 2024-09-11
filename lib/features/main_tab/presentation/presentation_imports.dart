import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extensions/context.dart';
import '../../../core/extensions/sheet.dart';
import '../../../core/extensions/spaced_column.dart';
import '../../../core/helpers/dependency_helper.dart';
import '../../../core/navigation/navigator.dart';
import '../../../core/shared_widgets/core_widgets/main_app_bar.dart';
import '../../../core/shared_widgets/core_widgets/visitor_login_sheet.dart';
import '../../ad/presentation/presentation_imports.dart';
import '../../address/presentation/presentation_imports.dart';
import '../../brand/presentation/presentation_imports.dart';
import '../../cart/presentation/presentation_imports.dart';
import '../../category/presentation/presentation_imports.dart';
import '../../product/presentation/presentation_imports.dart';

part 'cubit/main_cubit.dart';
part 'cubit/main_state.dart';
part 'pages/main_tab_page.dart';
