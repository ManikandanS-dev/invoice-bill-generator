import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../model/item.dart';
import '../add_dishes/add_dishes.dart';
import 'category_int.dart';
import 'search_bar_text.dart';

part 'filter_dishes.g.dart';

@Riverpod(keepAlive: true)
List<Item> filterDishes(FilterDishesRef ref) {
  final dishes = ref.watch(addDishesProProvider);
  final categoryInt = ref.watch(categoryIntProvider);
  final searchBar = ref.watch(serchBarProProvider);

  List<Item> fiterDish;

  if (dishes is AsyncData) {
    if (categoryInt == 'All') {
      fiterDish = dishes.value!;
    } else {
      fiterDish = dishes.value!
          .where((element) => element.categoris.contains(categoryInt))
          .toList();
    }
  } else {
    fiterDish = [];
  }

  if (searchBar.isNotEmpty) {
    fiterDish = fiterDish
        .where((element) =>
            element.name.toLowerCase().contains(searchBar.toLowerCase()))
        .toList();
  }

  return fiterDish;
}
