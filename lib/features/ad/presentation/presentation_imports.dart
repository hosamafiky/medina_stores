import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/error/failures.dart';
import '../../../core/extensions/context.dart';
import '../../../core/extensions/spaced_column.dart';
import '../../../core/extensions/spaced_row.dart';
import '../../../core/helpers/dependency_helper.dart';
import '../../../core/shared_widgets/core_widgets/image_widget.dart';
import '../../../core/shared_widgets/core_widgets/main_app_bar.dart';
import '../../../core/shared_widgets/core_widgets/shimmer_widget.dart';
import '../../../core/shared_widgets/video_widgets/video_widget.dart';
import '../../../core/standards/paginated_list.dart';
import '../../../core/standards/response_model.dart';
import '../../../core/standards/usecase_status.dart';
import '../domain/domain_imports.dart';

part '../presentation/cubit/ad_cubit.dart';
part '../presentation/cubit/ad_state.dart';
part '../presentation/pages/ads_page.dart';
part 'widgets/ad_shimmer_widget.dart';
part 'widgets/ad_widget.dart';
part 'widgets/ads_dot_indicator.dart';
part 'widgets/ads_scrolling_widget.dart';
part 'widgets/ads_widget.dart';
