import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../model/item.dart';

part 'add_category_repo.g.dart';

final cfstore = FirebaseFirestore.instance;
final fbAuth = FirebaseAuth.instance;

@Riverpod(keepAlive: true)
AddCategoryRepo categoryRepo(CategoryRepoRef ref) {
  return AddCategoryRepo();
}

class AddCategoryRepo {
  Future<DocumentReference> addCategory(String category) async {
    try {
      final String uid = fbAuth.currentUser!.uid;
      final DocumentReference id = await cfstore
          .collection('users')
          .doc(uid)
          .collection('category')
          .add({'category': category});
      return id;
    } catch (e) {
      print(e);
      throw e.toString();
    }
  }

  Future<List<Category>> getCategory() async {
    try {
      final String uid = fbAuth.currentUser!.uid;

      final snapshot = await cfstore
          .collection('users')
          .doc(uid)
          .collection('category')
          .orderBy("category")
          .get();

      final category = snapshot.docs;
      final doc = [
        Category.fromDoc(id: '1', category: 'All'),
        for (var value in category)
          Category.fromDoc(id: value.id, category: value.data()['category'])
      ];

      print(doc);
      return doc;
    } catch (e) {
      print(e);
      throw e.toString();
    }
  }
}
