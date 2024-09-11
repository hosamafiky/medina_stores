import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/resources/locale_keys.g.dart';
import '../../../core/error/failures.dart';
import '../../../core/extensions/context.dart';
import '../../../core/extensions/spaced_column.dart';
import '../../../core/extensions/spaced_row.dart';
import '../../../core/extensions/string.dart';
import '../../../core/helpers/dependency_helper.dart';
import '../../../core/navigation/navigator.dart';
import '../../../core/shared_widgets/core_widgets/image_widget.dart';
import '../../../core/shared_widgets/core_widgets/main_app_bar.dart';
import '../../../core/shared_widgets/core_widgets/shimmer_widget.dart';
import '../../../core/shared_widgets/state_managers/error_widget.dart';
import '../../../core/standards/usecase_status.dart';
import '../../product/presentation/presentation_imports.dart';
import '../domain/domain_imports.dart';

part 'cubit/brand_cubit.dart';
part 'cubit/brand_state.dart';
part 'pages/brands_page.dart';
part 'widgets/brand_card.dart';
part 'widgets/brands_horizontal_list.dart';
