import 'dart:convert';

import 'package:dartz/dartz.dart' hide id;
import 'package:medina_stores/core/extensions/error_handler_extension.dart';
import 'package:medina_stores/core/helpers/message_helper.dart';
import 'package:medina_stores/core/networking/api_constants.dart';

import '../../../../core/helpers/dependency_helper.dart';
import '../../../../core/networking/api_request.dart';
import '../../../../core/networking/api_service.dart';
import '../../../core/error/failures.dart';
import '../../../core/standards/response_model.dart';
import '../domain/domain_imports.dart';

part '../data/datasources/user_remote_data_source.dart';
part '../data/models/user_model.dart';
part '../data/repositories/user_repository_impl.dart';
