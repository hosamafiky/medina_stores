import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medina_stores/core/extensions/map_string.dart';
import 'package:medina_stores/core/extensions/spaced_column.dart';

import '../../../core/error/failures.dart';
import '../../../core/helpers/cache_helper.dart';
import '../../../core/helpers/dependency_helper.dart';
import '../../../core/helpers/message_helper.dart';
import '../../../core/navigation/navigator.dart';
import '../../../core/shared_widgets/core_widgets/main_app_bar.dart';
import '../../../core/shared_widgets/state_managers/loading_manager.dart';
import '../../../core/shared_widgets/theme_icon_button.dart';
import '../../../core/standards/usecase_status.dart';
import '../../user/presentation/presentation_imports.dart';
import '../domain/domain_imports.dart';

part '../presentation/cubit/profile_cubit.dart';
part '../presentation/cubit/profile_state.dart';
part 'pages/profile_tab_page.dart';
part 'widgets/profile_page_listener.dart';
