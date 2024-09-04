import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medina_stores/core/extensions/list.dart';
import 'package:medina_stores/core/extensions/sliver.dart';
import 'package:medina_stores/core/extensions/spaced_row.dart';
import 'package:medina_stores/core/shared_widgets/core_widgets/image_widget.dart';
import 'package:medina_stores/features/product/domain/domain_imports.dart';
import 'package:rxdart/rxdart.dart';

import '../../../config/resources/color_palettes/color_palette.dart';
import '../../../config/resources/locale_keys.g.dart';
import '../../../core/error/failures.dart';
import '../../../core/extensions/context.dart';
import '../../../core/extensions/spaced_column.dart';
import '../../../core/navigation/navigator.dart';
import '../../../core/shared_widgets/core_widgets/main_app_bar.dart';
import '../../../core/shared_widgets/state_managers/error_widget.dart';
import '../../../core/standards/usecase_status.dart';
import '../domain/domain_imports.dart';

part 'cubit/cart_cubit.dart';
part 'cubit/cart_state.dart';
part 'pages/cart_page.dart';
part 'widgets/add_cart_sheet.dart';
part 'widgets/add_to_cart_round_widget.dart';
