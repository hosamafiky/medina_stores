import 'package:dartz/dartz.dart' hide id;
import 'package:equatable/equatable.dart';
import 'package:medina_stores/core/standards/drop_down_item.dart';
import 'package:medina_stores/core/standards/paginated_list.dart';
import 'package:medina_stores/features/product/data/data_imports.dart';

import '../../../core/error/failures.dart';
import '../../../core/standards/response_model.dart';
import '../../../core/standards/use_case.dart';

part 'entities/product.dart';
part 'entities/product_data.dart';
part 'entities/product_details.dart';
part 'repositories/product_repository.dart';
part 'usecases/get_brand_products_usecase.dart';
part 'usecases/get_product_details_usecase.dart';
part 'usecases/get_related_products_usecase.dart';
part 'usecases/get_sub_category_products_usecase.dart';
part 'usecases/get_you_may_like_products_usecase.dart';
part 'usecases/toggle_favorite_usecase.dart';
