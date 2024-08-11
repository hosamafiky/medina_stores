import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:medina_stores/features/user/data/data_imports.dart';

import '../../../core/error/failures.dart';
import '../../../core/networking/response_model.dart';
import '../../../core/standards/use_case.dart';

part '../domain/entities/user.dart';
part '../domain/repositories/user_repository.dart';
part 'usecases/login_usecase.dart';
part 'usecases/logout_usecase.dart';
part 'usecases/register_usecase.dart';
part 'usecases/send_otp_usecase.dart';
part 'usecases/verify_otp_usecase.dart';
