import 'dart:convert';

import 'package:dartz/dartz.dart' hide id, order;
import 'package:easy_localization/easy_localization.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../../core/helpers/dependency_helper.dart';
import '../../../../core/networking/api_request.dart';
import '../../../../core/networking/api_service.dart';
import '../../../core/error/exceptions.dart';
import '../../../core/error/failures.dart';
import '../../../core/extensions/failure_type_extension.dart';
import '../../../core/helpers/cache_helper.dart';
import '../../../core/networking/api_constants.dart';
import '../../../core/standards/paginated_list.dart';
import '../../../core/standards/response_model.dart';
import '../domain/domain_imports.dart';

part 'datasources/ad_local_data_source.dart';
part 'datasources/ad_remote_data_source.dart';
part 'models/ad_model.dart';
part 'repositories/ad_repository_impl.dart';
