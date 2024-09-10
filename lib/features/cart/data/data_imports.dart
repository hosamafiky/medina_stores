import 'dart:convert';

import 'package:dartz/dartz.dart' hide id;
import 'package:easy_localization/easy_localization.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../../core/helpers/dependency_helper.dart';
import '../../../../core/networking/api_request.dart';
import '../../../../core/networking/api_service.dart';
import '../../../config/resources/locale_keys.g.dart';
import '../../../core/error/exceptions.dart';
import '../../../core/error/failures.dart';
import '../../../core/extensions/context.dart';
import '../../../core/extensions/error_handler_extension.dart';
import '../../../core/extensions/failure_type_extension.dart';
import '../../../core/navigation/navigator.dart';
import '../../../core/networking/api_constants.dart';
import '../../../core/standards/drop_down_item.dart';
import '../../../core/standards/response_model.dart';
import '../../product/data/data_imports.dart';
import '../domain/domain_imports.dart';

part 'datasources/cart_remote_data_source.dart';
part 'models/cart_data_model.dart';
part 'models/cart_model.dart';
part 'repositories/cart_repository_impl.dart';
