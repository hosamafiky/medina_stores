import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/error/failures.dart';
import '../../../core/extensions/context.dart';
import '../../../core/extensions/sheet.dart';
import '../../../core/extensions/spaced_column.dart';
import '../../../core/helpers/dependency_helper.dart';
import '../../../core/navigation/navigator.dart';
import '../../../core/shared_widgets/core_widgets/main_app_bar.dart';
import '../../../core/standards/usecase_status.dart';
import '../domain/domain_imports.dart';

part '../presentation/cubit/product_cubit.dart';
part '../presentation/cubit/product_state.dart';
part '../presentation/pages/products_page.dart';
part '../presentation/widgets/add_product_sheet.dart';
