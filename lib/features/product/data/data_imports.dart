import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:medina_stores/core/extensions/error_handler_extension.dart';
import 'package:medina_stores/core/networking/response_model.dart';

import '../../../../core/helpers/dependency_helper.dart';
import '../../../../core/networking/api_request.dart';
import '../../../../core/networking/api_service.dart';
import '../../../core/error/failures.dart';
import '../domain/domain_imports.dart';

part '../data/datasources/product_remote_data_source.dart';
part '../data/models/product_model.dart';
part '../data/repositories/product_repository_impl.dart';
