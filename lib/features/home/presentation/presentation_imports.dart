import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medina_stores/core/extensions/context.dart';
import 'package:medina_stores/core/helpers/message_helper.dart';
import 'package:medina_stores/core/shared_widgets/state_managers/loading_manager.dart';

import '../../../core/helpers/cache_helper.dart';
import '../../../core/navigation/navigator.dart';
import '../../../core/notifications/notification_helper.dart';
import '../../../core/shared_widgets/core_widgets/main_app_bar.dart';
import '../../../core/standards/usecase_status.dart';
import '../../user/presentation/presentation_imports.dart';

part 'pages/home_page.dart';
part 'widgets/home_page_listener.dart';
