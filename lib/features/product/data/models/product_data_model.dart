part of '../data_imports.dart';

class ProductDataModel extends ProductData {
  const ProductDataModel({
    required super.id,
    required super.name,
    required super.slug,
    required super.brand,
    required super.categories,
    required super.sku,
    required super.price,
    required super.discount,
    required super.discountType,
    required super.optionName,
    required super.priceAfterDiscount,
    required super.images,
    required super.createdAt,
  });

  factory ProductDataModel.fromProductData(ProductData productData) {
    return ProductDataModel(
      id: productData.id,
      name: productData.name,
      slug: productData.slug,
      brand: productData.brand,
      categories: productData.categories,
      sku: productData.sku,
      price: productData.price,
      discount: productData.discount,
      discountType: productData.discountType,
      optionName: productData.optionName,
      priceAfterDiscount: productData.priceAfterDiscount,
      images: productData.images,
      createdAt: productData.createdAt,
    );
  }

  factory ProductDataModel.fromJson(String str) => ProductDataModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductDataModel.fromMap(Map<String, dynamic> map) {
    return ProductDataModel(
      id: map["id"],
      name: map["name"],
      slug: map["slug"],
      brand: DropdownItemModel.fromMap(map["brand"]),
      categories: List<DropdownItemModel>.from(map["categories"].map((x) => DropdownItemModel.fromMap(x))),
      sku: map["sku"],
      price: map["price"],
      discount: map["discount"],
      discountType: map["discount_type"],
      optionName: DropdownItemModel.fromMap(map["option_name"]),
      priceAfterDiscount: map["price_after_discount"],
      images: List<ImageModel>.from(map["images"].map((x) => ImageModel.fromMap(x))),
      createdAt: DateFormat(ApiConstants.dateFormat).parse(map["created_at"]),
    );
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "slug": slug,
        "brand": (brand as DropdownItemModel).toMap(),
        "categories": List<dynamic>.from(categories.map((x) => (x as DropdownItemModel).toMap())),
        "sku": sku,
        "price": price,
        "discount": discount,
        "discount_type": discountType,
        "option_name": (optionName as DropdownItemModel).toMap(),
        "price_after_discount": priceAfterDiscount,
        "images": List<Map<String, dynamic>>.from(images.map((x) => (x as ImageModel).toMap())),
        "created_at": DateFormat(ApiConstants.dateFormat).format(createdAt),
      };
}

class ImageModel extends Image {
  const ImageModel({
    required super.id,
    required super.isMain,
    required super.image,
    required super.createdAt,
  });

  factory ImageModel.fromImage(Image image) {
    return ImageModel(
      id: image.id,
      isMain: image.isMain,
      image: image.image,
      createdAt: image.createdAt,
    );
  }

  factory ImageModel.fromJson(String str) => ImageModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ImageModel.fromMap(Map<String, dynamic> map) => ImageModel(
        id: map["id"],
        isMain: map["is_main"],
        image: map["image"],
        createdAt: DateFormat(ApiConstants.dateFormat).parse(map["created_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "is_main": isMain,
        "image": image,
        "created_at": DateFormat(ApiConstants.dateFormat).format(createdAt),
      };

  @override
  List<Object> get props => [id, isMain, image, createdAt];
}
