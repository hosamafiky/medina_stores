import 'dart:convert';

import 'package:dartz/dartz.dart' hide Option, id;
import 'package:easy_localization/easy_localization.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:medina_stores/core/extensions/context.dart';
import 'package:medina_stores/core/extensions/error_handler_extension.dart';
import 'package:medina_stores/core/extensions/failure_type_extension.dart';
import 'package:medina_stores/core/extensions/string.dart';
import 'package:medina_stores/core/navigation/navigator.dart';
import 'package:medina_stores/core/networking/api_constants.dart';
import 'package:medina_stores/core/standards/drop_down_item.dart';
import 'package:medina_stores/core/standards/paginated_list.dart';

import '../../../../core/helpers/dependency_helper.dart';
import '../../../../core/networking/api_request.dart';
import '../../../../core/networking/api_service.dart';
import '../../../core/error/exceptions.dart';
import '../../../core/error/failures.dart';
import '../../../core/helpers/cache_helper.dart';
import '../../../core/standards/response_model.dart';
import '../domain/domain_imports.dart';

part 'datasources/product_local_data_source.dart';
part 'datasources/product_remote_data_source.dart';
part 'models/product_data_model.dart';
part 'models/product_details_model.dart';
part 'models/product_model.dart';
part 'repositories/product_repository_impl.dart';
