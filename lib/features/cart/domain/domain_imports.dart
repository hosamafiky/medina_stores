import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:medina_stores/features/product/data/data_imports.dart';

import '../../../core/error/failures.dart';
import '../../../core/standards/response_model.dart';
import '../../../core/standards/use_case.dart';
import '../../product/domain/domain_imports.dart';

part '../domain/entities/cart.dart';
part '../domain/repositories/cart_repository.dart';
part 'usecases/add_to_cart_usecase.dart';
part 'usecases/get_cart_items_usecase.dart';
