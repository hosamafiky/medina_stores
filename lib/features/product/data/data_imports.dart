import 'dart:convert';

import 'package:dartz/dartz.dart' hide Option, id;
import 'package:easy_localization/easy_localization.dart';
import 'package:medina_stores/core/extensions/error_handler_extension.dart';
import 'package:medina_stores/core/networking/api_constants.dart';
import 'package:medina_stores/core/standards/drop_down_item.dart';
import 'package:medina_stores/core/standards/paginated_list.dart';

import '../../../../core/helpers/dependency_helper.dart';
import '../../../../core/networking/api_request.dart';
import '../../../../core/networking/api_service.dart';
import '../../../core/error/failures.dart';
import '../../../core/standards/response_model.dart';
import '../domain/domain_imports.dart';

part 'datasources/product_remote_data_source.dart';
part 'models/product_data_model.dart';
part 'models/product_details_model.dart';
part 'models/product_model.dart';
part 'repositories/product_repository_impl.dart';
