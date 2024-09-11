import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/resources/locale_keys.g.dart';
import '../../../core/extensions/context.dart';
import '../../../core/extensions/sheet.dart';
import '../../../core/helpers/dependency_helper.dart';
import '../../../core/helpers/dynamic_links_helper.dart';
import '../../../core/shared_widgets/core_widgets/visitor_login_sheet.dart';
import '../../main_tab/presentation/presentation_imports.dart';
import '../../me/presentation/presentation_imports.dart';
import '../../new_tab/presentation/presentation_imports.dart';

part 'cubit/layout_cubit.dart';
part 'pages/layout_page.dart';
part 'widgets/bottom_nav_bar_widget.dart';
