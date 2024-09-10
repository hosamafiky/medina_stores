import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/resources/locale_keys.g.dart';
import '../../../core/error/failures.dart';
import '../../../core/extensions/map_string.dart';
import '../../../core/extensions/spaced_column.dart';
import '../../../core/helpers/cache_helper.dart';
import '../../../core/helpers/dependency_helper.dart';
import '../../../core/helpers/message_helper.dart';
import '../../../core/navigation/navigator.dart';
import '../../../core/shared_widgets/core_widgets/main_app_bar.dart';
import '../../../core/shared_widgets/state_managers/loading_manager.dart';
import '../../../core/standards/usecase_status.dart';
import '../../language/presentation/presentation_imports.dart';
import '../../product/presentation/presentation_imports.dart';
import '../../user/presentation/presentation_imports.dart';
import '../domain/domain_imports.dart';

part 'cubit/profile_cubit.dart';
part 'cubit/profile_state.dart';
part 'pages/profile_tab_page.dart';
part 'widgets/profile_page_listener.dart';
