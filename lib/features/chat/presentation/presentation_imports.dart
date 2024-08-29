import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medina_stores/config/resources/color_palettes/color_palette.dart';
import 'package:medina_stores/core/extensions/context.dart';
import 'package:medina_stores/core/extensions/spaced_column.dart';
import 'package:medina_stores/core/navigation/navigator.dart';
import 'package:medina_stores/core/shared_widgets/core_widgets/app_textfield.dart';
import 'package:medina_stores/core/shared_widgets/core_widgets/image_widget.dart';
import 'package:medina_stores/core/shared_widgets/core_widgets/shimmer_widget.dart';
import 'package:medina_stores/core/standards/paginated_list.dart';
import 'package:medina_stores/core/standards/response_model.dart';
import 'package:medina_stores/core/utils/chat_utils.dart';
import 'package:medina_stores/features/chat/data/data_imports.dart';

import '../../../core/error/failures.dart';
import '../../../core/helpers/dependency_helper.dart';
import '../../../core/shared_widgets/core_widgets/main_app_bar.dart';
import '../../../core/standards/usecase_status.dart';
import '../domain/domain_imports.dart';

part 'cubit/chat_cubit.dart';
part 'cubit/chat_state.dart';
part 'pages/chat_page.dart';
part 'pages/chats_page.dart';
part 'widgets/audio_message.dart';
part 'widgets/chat_input_widget.dart';
part 'widgets/chat_message_widget.dart';
part 'widgets/chat_widget.dart';
part 'widgets/image_message.dart';
part 'widgets/text_message.dart';
part 'widgets/video_message.dart';
