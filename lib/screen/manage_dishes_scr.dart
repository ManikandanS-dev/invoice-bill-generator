import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invoice/provider/add_category/add_category.dart';
import 'package:invoice/provider/filter_dishes/filter_dishes.dart';

import '../constant/kconst.dart';
import '../provider/add_dishes/add_dishes.dart';
import '../provider/filter_dishes/category_int.dart';
import '../widget/add_category.dart';
import '../widget/add_dishes.dart';
import '../widget/search_bar.dart';

class ManageDishes extends ConsumerWidget {
  const ManageDishes({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final category = ref.watch(categoryListProvider);
    final dishes = ref.watch(filterDishesProvider);
    final asyncdishes = ref.watch(addDishesProProvider);
    final selectCategory = ref.watch(categoryIntProvider);

    Future<dynamic> addCategory() {
      return showDialog(
        context: context,
        builder: (context) => const AddCategory(),
      );
    }

    Future<dynamic> addDishes() {
      return showDialog(
        context: context,
        builder: (context) => const AddDishes(),
      );
    }

    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(
                color: Kconst.text4,
                border: Border.all(width: 1, color: Kconst.text3)),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    'Dishes Category',
                    style: Kconst.kTextTheme(context).headlineSmall!.copyWith(
                        fontWeight: FontWeight.w400, color: Kconst.yellow2),
                  ),
                ),
                Expanded(
                  child: category.when(
                    data: (data) => Stack(
                      children: [
                        ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            final value = data[index];
                            return TextButton(
                              onPressed: () {
                                ref
                                    .read(categoryIntProvider.notifier)
                                    .addCategoryString(value.category);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: value.category == selectCategory
                                          ? Kconst.yellow
                                          : Kconst.text3,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(8),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        const SizedBox(
                                          width: 30,
                                        ),
                                        Expanded(
                                          child: Text(
                                            value.category,
                                            softWrap: true,
                                            style: Kconst.kTextTheme(context)
                                                .labelLarge!
                                                .copyWith(
                                                  fontWeight: value.category ==
                                                          selectCategory
                                                      ? FontWeight.bold
                                                      : FontWeight.w400,
                                                  color: value.category ==
                                                          selectCategory
                                                      ? Kconst.text4
                                                      : Kconst.text,
                                                ),
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.delete_forever,
                                            color: Kconst.red2,
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            );
                          },
                        ),
                        Positioned(
                          bottom: 20,
                          right: 20,
                          child: FloatingActionButton(
                            backgroundColor: Kconst.red,
                            child: const Icon(Icons.add),
                            onPressed: () {
                              addCategory();
                            },
                          ),
                        )
                      ],
                    ),
                    error: (error, stackTrace) => Text(error.toString()),
                    loading: () => const CircularProgressIndicator(),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 6,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                width: double.infinity,
                height: 56,
                color: Kconst.backround,
                child: const CustomSearchBar(),
              ),
              Expanded(
                child: asyncdishes.isLoading
                    ? const CircularProgressIndicator()
                    : Container(
                        color: Kconst.backround,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8, left: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: Text(
                                  'Manage Dishes',
                                  style: Kconst.kTextTheme(context)
                                      .headlineSmall!
                                      .copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: Kconst.text),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  color: Kconst.backround,
                                  child: Stack(
                                    children: [
                                      GridView.builder(
                                        gridDelegate:
                                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                                maxCrossAxisExtent: 220,
                                                mainAxisExtent: 160,
                                                childAspectRatio: 1),
                                        itemBuilder: (context, index) {
                                          final value = dishes[index];
                                          return Card(
                                            shadowColor: Kconst.green,
                                            margin: const EdgeInsets.all(4),
                                            color: Kconst.text3,
                                            elevation: 2,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            clipBehavior: Clip.hardEdge,
                                            child: Stack(
                                              children: [
                                                Image.network(
                                                  width: double.infinity,
                                                  height: double.infinity,
                                                  value.imageUrl,
                                                  fit: BoxFit.cover,
                                                ),
                                                Positioned(
                                                  bottom: 0,
                                                  right: 0,
                                                  left: 0,
                                                  child: Container(
                                                      color:
                                                          const Color.fromARGB(
                                                              115, 0, 0, 0),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Expanded(
                                                                  child: Text(
                                                                      softWrap:
                                                                          true,
                                                                      maxLines:
                                                                          1,
                                                                      value
                                                                          .name),
                                                                ),
                                                                Text(
                                                                    softWrap:
                                                                        true,
                                                                    maxLines: 1,
                                                                    " (Price: ${value.price})"),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                Expanded(
                                                                  child: Text(
                                                                      "Discount: ${value.discoint}%"),
                                                                ),
                                                                IconButton(
                                                                  onPressed:
                                                                      () {},
                                                                  icon: Icon(
                                                                    Icons.edit,
                                                                    color: Kconst
                                                                        .orange2,
                                                                  ),
                                                                ),
                                                                IconButton(
                                                                  onPressed:
                                                                      () {},
                                                                  icon: Icon(
                                                                    Icons
                                                                        .delete,
                                                                    color: Kconst
                                                                        .red2,
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      )),
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                        itemCount: dishes.length,
                                      ),
                                      Positioned(
                                        bottom: 20,
                                        right: 20,
                                        child: FloatingActionButton(
                                          backgroundColor: Kconst.red,
                                          child: const Icon(Icons.add),
                                          onPressed: () {
                                            addDishes();
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
