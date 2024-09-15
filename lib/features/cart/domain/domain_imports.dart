import 'package:dartz/dartz.dart' hide Option;
import 'package:equatable/equatable.dart';

import '../../../core/error/failures.dart';
import '../../../core/standards/drop_down_item.dart';
import '../../../core/standards/response_model.dart';
import '../../../core/standards/use_case.dart';
import '../../product/domain/domain_imports.dart';

part 'entities/cart.dart';
part 'entities/cart_data.dart';
part 'entities/checkout_data.dart';
part 'entities/payment_gate.dart';
part 'repositories/cart_repository.dart';
part 'usecases/add_to_cart_usecase.dart';
part 'usecases/get_cart_items_usecase.dart';
part 'usecases/get_checkout_data_usecase.dart';
part 'usecases/get_payment_gates_usecase.dart';
part 'usecases/remove_from_cart_usecase.dart';
part 'usecases/update_cart_quantity_usecase.dart';
