import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medina_stores/config/resources/locale_keys.g.dart';
import 'package:medina_stores/features/product/presentation/presentation_imports.dart';

import '../../../core/error/failures.dart';
import '../../../core/helpers/dependency_helper.dart';
import '../../../core/shared_widgets/core_widgets/main_app_bar.dart';
import '../../../core/standards/usecase_status.dart';
import '../domain/domain_imports.dart';

part 'cubit/new_tab_cubit.dart';
part 'cubit/new_tab_state.dart';
part 'pages/new_tab_page.dart';
