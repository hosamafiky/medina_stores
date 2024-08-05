import 'dart:convert';

import 'package:dartz/dartz.dart';

import '../../../../core/helpers/dependency_helper.dart';
import '../../../../core/networking/api_constants.dart';
import '../../../../core/networking/api_request.dart';
import '../../../../core/networking/api_service.dart';
import '../../../core/error/failures.dart';
import '../../../core/extensions/error_handler_extension.dart';
import '../domain/domain_imports.dart';

part '../data/datasources/post_remote_data_source.dart';
part '../data/models/post_model.dart';
part '../data/repositories/post_repository_impl.dart';
