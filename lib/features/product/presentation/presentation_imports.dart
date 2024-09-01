import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medina_stores/config/resources/locale_keys.g.dart';
import 'package:medina_stores/core/extensions/sliver.dart';
import 'package:medina_stores/core/extensions/spaced_row.dart';
import 'package:medina_stores/core/shared_widgets/core_widgets/dynamic_height_gridview_widget.dart';
import 'package:medina_stores/core/shared_widgets/core_widgets/image_widget.dart';
import 'package:medina_stores/core/standards/paginated_list.dart';
import 'package:medina_stores/core/standards/response_model.dart';
import 'package:medina_stores/features/brand/domain/domain_imports.dart';
import 'package:medina_stores/features/product/data/data_imports.dart';

import '../../../core/error/failures.dart';
import '../../../core/helpers/dependency_helper.dart';
import '../../../core/navigation/navigator.dart';
import '../../../core/shared_widgets/core_widgets/main_app_bar.dart';
import '../../../core/standards/usecase_status.dart';
import '../../sub_category/domain/domain_imports.dart';
import '../domain/domain_imports.dart';

part 'cubit/product_cubit.dart';
part 'cubit/product_state.dart';
part 'pages/product_page.dart';
part 'pages/products_page.dart';
part 'widgets/product_widget.dart';