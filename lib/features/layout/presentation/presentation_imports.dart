import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medina_stores/core/extensions/context.dart';
import 'package:medina_stores/core/extensions/sheet.dart';
import 'package:medina_stores/core/helpers/dynamic_links_helper.dart';
import 'package:medina_stores/core/shared_widgets/core_widgets/visitor_login_sheet.dart';
import 'package:medina_stores/features/main_tab/presentation/presentation_imports.dart';
import 'package:medina_stores/features/new_tab/presentation/presentation_imports.dart';
import 'package:medina_stores/features/profile/presentation/presentation_imports.dart';

import '../../../config/resources/locale_keys.g.dart';
import '../../../core/helpers/dependency_helper.dart';

part 'cubit/layout_cubit.dart';
part 'pages/layout_page.dart';
part 'widgets/bottom_nav_bar_widget.dart';
