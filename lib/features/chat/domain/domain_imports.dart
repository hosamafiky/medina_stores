import 'package:dartz/dartz.dart' hide id;
import 'package:equatable/equatable.dart';
import 'package:medina_stores/core/standards/paginated_list.dart';

import '../../../core/error/failures.dart';
import '../../../core/standards/response_model.dart';
import '../../../core/standards/use_case.dart';

part '../domain/entities/chat.dart';
part '../domain/entities/chat_message.dart';
part '../domain/repositories/chat_repository.dart';
part '../domain/usecases/get_chats_usecase.dart';
