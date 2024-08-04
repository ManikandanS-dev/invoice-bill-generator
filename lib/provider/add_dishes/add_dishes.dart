import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/item.dart';
import 'add_dishes_repo.dart';

part 'add_dishes.g.dart';

final cfstore = FirebaseFirestore.instance;
final fbAuth = FirebaseAuth.instance;

@Riverpod(keepAlive: true)
class AddDishesPro extends _$AddDishesPro {
  @override
  FutureOr<List<Item>> build() {
    print('setup Dishes');
    return getDishes();
  }

  Future<void> addDishes(
      {required String name,
      required String price,
      required List category,
      required String discount,
      required String imageUrl}) async {
    final id = await ref
        .read(dishesRepositoriesProvider)
        .addDishes(name, price, category, discount, imageUrl);
    final newDishes = Item.fromDoc(
        id: id.id,
        name: name,
        price: price,
        discoint: discount,
        categoris: category,
        imageUrl: imageUrl);
    state = AsyncData([newDishes, ...?state.value]);
  }

  Future<List<Item>> getDishes() async {
    state = const AsyncLoading();
    return await ref.read(dishesRepositoriesProvider).getDishes();
  }
}
