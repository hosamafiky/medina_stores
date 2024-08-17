import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' hide Slider;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medina_stores/core/extensions/context.dart';
import 'package:medina_stores/core/extensions/spaced_column.dart';
import 'package:medina_stores/core/extensions/spaced_row.dart';
import 'package:medina_stores/core/shared_widgets/core_widgets/image_widget.dart';
import 'package:medina_stores/core/shared_widgets/core_widgets/shimmer_widget.dart';

import '../../../core/error/failures.dart';
import '../../../core/standards/paginated_list.dart';
import '../../../core/standards/response_model.dart';
import '../../../core/standards/usecase_status.dart';
import '../domain/domain_imports.dart';

part 'cubit/slider_cubit.dart';
part 'cubit/slider_state.dart';
part 'widgets/dots_indicator_widget.dart';
part 'widgets/slider_shimmer_widget.dart';
part 'widgets/slider_widget.dart';
part 'widgets/sliders_listview_widget.dart';
part 'widgets/sliders_widget.dart';
