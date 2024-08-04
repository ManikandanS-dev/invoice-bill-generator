import 'package:invoice/provider/add_category/add_category_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../model/item.dart';

part 'add_category.g.dart';

@Riverpod(keepAlive: true)
class CategoryList extends _$CategoryList {
  @override
  FutureOr<List<Category>> build() {
    print('setup');
    return getCategory();
  }

  Future<List<Category>> getCategory() async {
    state = const AsyncLoading();
    await Future.delayed(const Duration(minutes: 5));
    return await ref.read(categoryRepoProvider).getCategory();
  }

  Future<void> addCategory(String category) async {
    final id = await ref.read(categoryRepoProvider).addCategory(category);
    final newCategory = Category.fromDoc(id: id.id, category: category);
    state = AsyncValue.data([...?state.value, newCategory]);
  }
}
