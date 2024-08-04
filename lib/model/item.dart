import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'item.freezed.dart';

@freezed
class Item with _$Item {
  const factory Item({
    required String id,
    required String name,
    required String price,
    required String imageUrl,
    @Default('0.0') String discoint,
    @Default([]) List categoris,
  }) = _Item;

  factory Item.fromDoc(
      {required String id,
      required String name,
      required String price,
      required List categoris,
      required String discoint,
      required String imageUrl}) {
    return Item(
        id: id,
        name: name,
        price: price,
        categoris: categoris,
        imageUrl: imageUrl);
  }
}

@freezed
class Category with _$Category {
  const factory Category({
    required String id,
    required String category,
  }) = _Category;

  factory Category.fromDoc({required String id, required String category}) {
    return Category(id: id, category: category);
  }
}
