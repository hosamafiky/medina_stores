import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medina_stores/config/resources/locale_keys.g.dart';
import 'package:medina_stores/core/extensions/context.dart';
import 'package:medina_stores/core/extensions/spaced_column.dart';
import 'package:medina_stores/core/helpers/url_launcher_helper.dart';
import 'package:medina_stores/core/standards/paginated_list.dart';
import 'package:medina_stores/core/standards/response_model.dart';
import 'package:medina_stores/features/ad/data/data_imports.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/error/failures.dart';
import '../../../core/helpers/dependency_helper.dart';
import '../../../core/shared_widgets/core_widgets/image_widget.dart';
import '../../../core/shared_widgets/core_widgets/main_app_bar.dart';
import '../../../core/shared_widgets/core_widgets/shimmer_widget.dart';
import '../../../core/shared_widgets/core_widgets/video_widget.dart';
import '../../../core/shared_widgets/state_managers/error_widget.dart';
import '../../../core/standards/usecase_status.dart';
import '../domain/domain_imports.dart';

part 'cubit/ad_cubit.dart';
part 'cubit/ad_state.dart';
part 'pages/ads_page.dart';
part 'widgets/ad_shimmer_widget.dart';
part 'widgets/ad_widget.dart';
part 'widgets/ads_scrolling_widget.dart';
part 'widgets/ads_widget.dart';
