import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/item.dart';

part 'add_dishes_repo.g.dart';

final cfstore = FirebaseFirestore.instance;
final fbAuth = FirebaseAuth.instance;

@Riverpod(keepAlive: true)
DishesRepo dishesRepositories(DishesRepositoriesRef ref) {
  return DishesRepo();
}

class DishesRepo {
  Future<List<Item>> getDishes() async {
    try {
      final uid = fbAuth.currentUser!.uid;
      final snapshot =
          await cfstore.collection('users').doc(uid).collection('dishes').get();
      final dishesDoc = snapshot.docs;
      final dishesList = [
        for (var value in dishesDoc)
          Item.fromDoc(
              id: value.id,
              name: value.data()['name'],
              price: value.data()['price'],
              imageUrl: value.data()['imageUrl'],
              discoint: value.data()['discount'],
              categoris: value.data()['category'] as List)
      ];
      print(dishesList);
      return dishesList;
    } catch (e) {
      print("dishesList  $e");

      throw e.toString();
    }
  }

  Future<DocumentReference> addDishes(String name, String price, List category,
      String discount, String imageUrl) async {
    try {
      final uid = fbAuth.currentUser!.uid;
      final DocumentReference id =
          await cfstore.collection('users').doc(uid).collection('dishes').add({
        'name': name,
        'price': price,
        'category': category,
        'discount': discount,
        'imageUrl': imageUrl
      });
      return id;
    } catch (e) {
      throw e.toString();
    }
  }
}
