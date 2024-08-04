import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'category_int.g.dart';

@Riverpod(keepAlive: true)
class CategoryInt extends _$CategoryInt {
  @override
  String build() {
    return 'All';
  }

  void addCategoryString(String category) {
    state = category;
  }
}
