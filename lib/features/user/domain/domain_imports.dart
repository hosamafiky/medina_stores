import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../core/error/failures.dart';
import '../../../core/notifications/notification_helper.dart';
import '../../../core/standards/response_model.dart';
import '../../../core/standards/use_case.dart';
import '../data/data_imports.dart';

part 'entities/user.dart';
part 'entities/user_profile.dart';
part 'repositories/user_repository.dart';
part 'usecases/delete_account_usecase.dart';
part 'usecases/get_user_data_usecase.dart';
part 'usecases/login_usecase.dart';
part 'usecases/logout_usecase.dart';
part 'usecases/register_usecase.dart';
part 'usecases/reset_password_usecase.dart';
part 'usecases/send_otp_usecase.dart';
part 'usecases/update_password_usecase.dart';
part 'usecases/update_profile_usecase.dart';
part 'usecases/verify_otp_usecase.dart';
part 'usecases/verify_pass_otp_usecase.dart';
