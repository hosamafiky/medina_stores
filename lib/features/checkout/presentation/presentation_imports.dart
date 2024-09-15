import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medina_stores/core/extensions/context.dart';
import 'package:medina_stores/core/extensions/sheet.dart';
import 'package:medina_stores/core/extensions/sliver.dart';
import 'package:medina_stores/core/extensions/spaced_column.dart';

import '../../../config/resources/locale_keys.g.dart';
import '../../../core/error/failures.dart';
import '../../../core/helpers/dependency_helper.dart';
import '../../../core/navigation/navigator.dart';
import '../../../core/shared_widgets/core_widgets/app_textfield.dart';
import '../../../core/shared_widgets/core_widgets/image_widget.dart';
import '../../../core/standards/response_model.dart';
import '../../../core/standards/usecase_status.dart';
import '../../cart/presentation/presentation_imports.dart';
import '../domain/domain_imports.dart';

part 'cubit/checkout_cubit.dart';
part 'cubit/checkout_state.dart';
part 'pages/checkout_page.dart';
part 'widgets/change_payment_gate_sheet.dart';
part 'widgets/coupon_code_widget.dart';
part 'widgets/place_order_widget.dart';
