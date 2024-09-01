part of '../data_imports.dart';

class ProductDetailsModel extends ProductDetails {
  const ProductDetailsModel({
    required super.data,
    required super.optionCategories,
  });

  factory ProductDetailsModel.fromProductDetails(ProductDetails productDetails) {
    return ProductDetailsModel(
      data: productDetails.data,
      optionCategories: productDetails.optionCategories,
    );
  }

  factory ProductDetailsModel.fromJson(String str) => ProductDetailsModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductDetailsModel.fromMap(Map<String, dynamic> map) => ProductDetailsModel(
        data: ProductDataModel.fromMap(map["data"]),
        optionCategories: List<OptionCategory>.from(map["option_categories"].map((x) => OptionCategoryModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "data": (data as ProductDataModel).toMap(),
        "option_categories": List<dynamic>.from(optionCategories.map((x) => (x as OptionCategoryModel).toMap())),
      };
}

class OptionCategoryModel extends OptionCategory {
  const OptionCategoryModel({
    required super.id,
    required super.name,
    required super.isRequired,
    required super.type,
    required super.options,
  });

  factory OptionCategoryModel.fromOptionCategory(OptionCategory optionCategory) {
    return OptionCategoryModel(
      id: optionCategory.id,
      name: optionCategory.name,
      isRequired: optionCategory.isRequired,
      type: optionCategory.type,
      options: optionCategory.options,
    );
  }

  factory OptionCategoryModel.fromJson(String str) => OptionCategoryModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OptionCategoryModel.fromMap(Map<String, dynamic> json) => OptionCategoryModel(
        id: json["id"],
        name: json["name"],
        isRequired: json["is_required"],
        type: json["type"],
        options: List<OptionModel>.from(json["options"].map((x) => OptionModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "is_required": isRequired,
        "type": type,
        "options": List<Map<String, dynamic>>.from(options.map((x) => (x as OptionModel).toMap())),
      };
}

class OptionModel extends Option {
  const OptionModel({
    required super.id,
    required super.price,
    required super.discount,
    required super.discountType,
    required super.priceAfterDiscount,
    required super.optionName,
  });

  factory OptionModel.fromOption(Option option) {
    return OptionModel(
      id: option.id,
      price: option.price,
      discount: option.discount,
      discountType: option.discountType,
      priceAfterDiscount: option.priceAfterDiscount,
      optionName: option.optionName,
    );
  }

  factory OptionModel.fromJson(String str) => OptionModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OptionModel.fromMap(Map<String, dynamic> json) => OptionModel(
        id: json["id"],
        price: json["price"],
        discount: json["discount"],
        discountType: json["discount_type"],
        priceAfterDiscount: json["price_after_discount"],
        optionName: DropdownItemModel.fromMap(json["option_name"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "price": price,
        "discount": discount,
        "discount_type": discountType,
        "price_after_discount": priceAfterDiscount,
        "option_name": (optionName as DropdownItemModel).toMap(),
      };
}
