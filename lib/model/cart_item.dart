import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_item.freezed.dart';
part 'cart_item.g.dart';

@freezed
class CartItem with _$CartItem {
  const factory CartItem({
    required String id,
    required String name,
    required double price,
    @Default(0.0) double discount,
    required int quantity,
  }) = _CartItem;

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);

  factory CartItem.from({
    required String id,
    required String name,
    required double price,
    required int quantity,
  }) {
    return CartItem(
      id: id,
      name: name,
      price: price,
      quantity: quantity,
    );
  }
}
