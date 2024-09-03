import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medina_stores/core/extensions/spaced_row.dart';
import 'package:medina_stores/features/product/domain/domain_imports.dart';

import '../../../config/resources/color_palettes/color_palette.dart';
import '../../../core/error/failures.dart';
import '../../../core/extensions/context.dart';
import '../../../core/extensions/sheet.dart';
import '../../../core/extensions/spaced_column.dart';
import '../../../core/helpers/dependency_helper.dart';
import '../../../core/navigation/navigator.dart';
import '../../../core/shared_widgets/core_widgets/main_app_bar.dart';
import '../../../core/standards/usecase_status.dart';
import '../domain/domain_imports.dart';

part 'cubit/cart_cubit.dart';
part 'cubit/cart_state.dart';
part 'pages/cart_page.dart';
part 'widgets/add_cart_sheet.dart';
part 'widgets/add_to_cart_round_widget.dart';
