import 'dart:convert';

import 'package:dartz/dartz.dart' hide id;
import 'package:easy_localization/easy_localization.dart';
import 'package:medina_stores/core/networking/api_constants.dart';
import 'package:medina_stores/core/standards/paginated_list.dart';

// import '../../../../core/helpers/dependency_helper.dart';
import '../../../../core/networking/api_request.dart';
// import '../../../../core/networking/api_service.dart';
import '../../../core/error/failures.dart';
import '../../../core/extensions/error_handler_extension.dart';
import '../../../core/standards/response_model.dart';
import '../domain/domain_imports.dart';

part '../data/datasources/chat_remote_data_source.dart';
part '../data/models/chat_message_model.dart';
part '../data/models/chat_model.dart';
part '../data/repositories/chat_repository_impl.dart';