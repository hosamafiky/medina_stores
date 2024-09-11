import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medina_stores/config/resources/locale_keys.g.dart';
import 'package:medina_stores/core/helpers/dependency_helper.dart';
import 'package:medina_stores/core/helpers/url_launcher_helper.dart';
import 'package:medina_stores/core/networking/api_constants.dart';
import 'package:medina_stores/core/shared_widgets/state_managers/error_widget.dart';
import 'package:medina_stores/core/standards/response_model.dart';

import '../../../core/error/failures.dart';
import '../../../core/shared_widgets/core_widgets/main_app_bar.dart';
import '../../../core/standards/usecase_status.dart';
import '../domain/domain_imports.dart';

part 'cubit/static_page_cubit.dart';
part 'cubit/static_page_state.dart';
part 'pages/about_us_page.dart';
part 'pages/contact_us_page.dart';
part 'pages/license_page.dart';
part 'pages/privacy_policy_page.dart';
part 'pages/shipping_policy_page.dart';
part 'pages/terms_page.dart';
part 'widgets/static_page_data_widget.dart';
