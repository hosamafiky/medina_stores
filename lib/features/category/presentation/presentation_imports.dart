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
import '../../../core/shared_widgets/core_widgets/image_widget.dart';
import '../../../core/shared_widgets/core_widgets/main_app_bar.dart';
import '../../../core/standards/usecase_status.dart';
import '../../sub_category/presentation/presentation_imports.dart';
import '../domain/domain_imports.dart';

part '../presentation/cubit/category_cubit.dart';
part '../presentation/cubit/category_state.dart';
part '../presentation/widgets/add_category_sheet.dart';
part '../presentation/widgets/categories_horizontal_list.dart';
part '../presentation/widgets/category_card.dart';
part 'pages/categories_page.dart';
