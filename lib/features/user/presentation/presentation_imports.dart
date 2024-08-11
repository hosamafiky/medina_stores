import 'dart:async';

import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:equatable/equatable.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medina_stores/config/resources/color_palettes/color_palette.dart';
import 'package:medina_stores/config/text_styles/app_font_weights.dart';
import 'package:medina_stores/core/extensions/context.dart';
import 'package:medina_stores/core/extensions/duration.dart';
import 'package:medina_stores/core/extensions/spaced_column.dart';
import 'package:medina_stores/core/extensions/spaced_row.dart';
import 'package:medina_stores/core/helpers/message_helper.dart';
import 'package:medina_stores/core/helpers/validation_helper.dart';
import 'package:medina_stores/core/networking/response_model.dart';
import 'package:medina_stores/core/shared_widgets/core_widgets/app_textfield.dart';
import 'package:medina_stores/core/shared_widgets/state_managers/loading_manager.dart';
import 'package:pinput/pinput.dart';

import '../../../config/resources/locale_keys.g.dart';
import '../../../core/error/failures.dart';
import '../../../core/helpers/cache_helper.dart';
import '../../../core/navigation/navigator.dart';
import '../../../core/shared_widgets/core_widgets/main_app_bar.dart';
import '../../../core/standards/usecase_status.dart';
import '../../home/presentation/presentation_imports.dart';
import '../data/data_imports.dart';
import '../domain/domain_imports.dart';

part '../presentation/cubit/user_cubit.dart';
part '../presentation/cubit/user_state.dart';
part 'pages/login_page.dart';
part 'pages/otp_page.dart';
part 'pages/register_screen.dart';
part 'widgets/login_form.dart';
part 'widgets/login_now_widget.dart';
part 'widgets/login_page_listener.dart';
part 'widgets/otp_timer_widget.dart';
part 'widgets/register_form.dart';
part 'widgets/register_now_widget.dart';
part 'widgets/register_page_listener.dart';
