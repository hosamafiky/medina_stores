import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medina_stores/core/extensions/context.dart';
import 'package:medina_stores/core/extensions/spaced_column.dart';
import 'package:medina_stores/core/helpers/message_helper.dart';
import 'package:medina_stores/core/shared_widgets/core_widgets/app_textfield.dart';

import '../../../core/error/failures.dart';
import '../../../core/helpers/cache_helper.dart';
import '../../../core/navigation/navigator.dart';
import '../../../core/shared_widgets/core_widgets/main_app_bar.dart';
import '../../../core/standards/usecase_status.dart';
import '../../home/presentation/pages/home_page.dart';
import '../data/data_imports.dart';
import '../domain/domain_imports.dart';

part '../presentation/cubit/user_cubit.dart';
part '../presentation/cubit/user_state.dart';
part 'pages/login_page.dart';
part 'widgets/login_form.dart';
