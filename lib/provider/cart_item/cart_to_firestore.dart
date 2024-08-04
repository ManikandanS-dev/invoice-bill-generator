import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cart_to_firestore.g.dart';

final cfstore = FirebaseFirestore.instance;
final fbAuth = FirebaseAuth.instance;

@riverpod
CartFireStore cartTofireRepo(CartTofireRepoRef ref) {
  return CartFireStore();
}

class CartFireStore {
  Future<void> saveToFireBase(List cart) async {
    final uid = fbAuth.currentUser!.uid;
    try {
      await cfstore.collection('users').doc(uid).collection('bills').add(
        {
          'cart': cart,
          'timestamp': Timestamp.now(),
        },
      );
    } catch (e) {
      print(e);
      throw e.toString();
    }
  }
}
