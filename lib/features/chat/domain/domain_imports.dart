import 'dart:io';

import 'package:dartz/dartz.dart' hide id;
import 'package:equatable/equatable.dart';

import '../../../core/error/failures.dart';
import '../../../core/standards/paginated_list.dart';
import '../../../core/standards/response_model.dart';
import '../../../core/standards/use_case.dart';

part 'entities/chat.dart';
part 'entities/chat_message.dart';
part 'repositories/chat_repository.dart';
part 'usecases/get_chats_usecase.dart';
part 'usecases/get_messages_usecase.dart';
