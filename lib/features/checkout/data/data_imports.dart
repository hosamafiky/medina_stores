import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:medina_stores/core/extensions/context.dart';
import 'package:medina_stores/core/extensions/failure_type_extension.dart';

import '../../../../core/helpers/dependency_helper.dart';
import '../../../../core/networking/api_request.dart';
import '../../../../core/networking/api_service.dart';
import '../../../config/resources/locale_keys.g.dart';
import '../../../core/error/exceptions.dart';
import '../../../core/error/failures.dart';
import '../../../core/navigation/navigator.dart';
import '../../../core/networking/api_constants.dart';
import '../../../core/standards/drop_down_item.dart';
import '../../../core/standards/response_model.dart';
import '../../cart/data/data_imports.dart';
import '../domain/domain_imports.dart';

part 'datasources/checkout_remote_data_source.dart';
part 'models/checkout_model.dart';
part 'models/payment_gate_model.dart';
part 'repositories/checkout_repository_impl.dart';
