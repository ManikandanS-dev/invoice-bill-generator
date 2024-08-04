import 'package:invoice/model/cart_item.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'cart_to_firestore.dart';

part 'cart_item.g.dart';

@Riverpod(keepAlive: true)
class Cart extends _$Cart {
  @override
  List<CartItem> build() {
    return [];
  }

  void addCart({
    required String id,
    required String name,
    required double price,
    required int quantity,
  }) {
    state = state.map((e) {
      if (e.id == id) {
        return e.copyWith(quantity: e.quantity + quantity);
      }
      return e;
    }).toList();

    final bool isNew = state.any((element) => element.id == id);

    if (!isNew) {
      final cart = CartItem.from(
        id: id,
        name: name,
        price: price,
        quantity: quantity,
      );

      state = [...state, cart];
    }
  }

  void clearCart() {
    state = [];
  }

  void removeItemCart(String id) {
    state = state.where((e) => e.id != id).toList();
  }

  void saveFireStore() {
    final cart = state.map((e) => e.toJson()).toList();
    ref.read(cartTofireRepoProvider).saveToFireBase(cart);
    state = [];
  }
}
