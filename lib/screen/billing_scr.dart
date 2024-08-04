import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constant/kconst.dart';
import '../provider/add_category/add_category.dart';
import '../provider/add_dishes/add_dishes.dart';
import '../provider/cart_item/cart_item.dart';
import '../provider/filter_dishes/category_int.dart';
import '../provider/filter_dishes/filter_dishes.dart';

import '../widget/bill_details.dart';
import '../widget/billing_category_loading.dart';
import '../widget/search_bar.dart';

class BillingScr extends ConsumerWidget {
  const BillingScr({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final category = ref.watch(categoryListProvider);
    final dishes = ref.watch(filterDishesProvider);
    final asyncdishes = ref.watch(addDishesProProvider);
    final selectCategory = ref.watch(categoryIntProvider);

    return Row(
      children: [
        Expanded(
          flex: 8,
          child: Column(
            children: [
              Container(
                  height: 60,
                  padding: const EdgeInsets.all(8),
                  width: double.infinity,
                  decoration: BoxDecoration(color: Kconst.backround),
                  child: const CustomSearchBar()),
              Container(
                padding: const EdgeInsets.only(left: 10),
                width: double.infinity,
                color: Kconst.backround,
                child: Text(
                  'Category',
                  style: Kconst.kTextTheme(context).titleMedium,
                ),
              ),
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Kconst.backround,
                ),
                child: category.when(
                  data: (data) => ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final value = data[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 9),
                        child: InkWell(
                          onTap: () {
                            ref
                                .read(categoryIntProvider.notifier)
                                .addCategoryString(value.category);
                          },
                          child: Container(
                            height: 10,
                            width: 100,
                            decoration: BoxDecoration(
                              color: selectCategory == value.category
                                  ? Kconst.red2
                                  : Kconst.text3,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                                child: Text(
                              value.category,
                              maxLines: 1,
                              softWrap: true,
                            )),
                          ),
                        ),
                      );
                    },
                  ),
                  error: (error, stackTrace) => Text(error.toString()),
                  loading: () => const BillingCategoryLoading(),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 10),
                width: double.infinity,
                color: Kconst.backround,
                child: Text(
                  'Products',
                  style: Kconst.kTextTheme(context).titleMedium,
                ),
              ),
              asyncdishes.isLoading
                  ? const Expanded(child: CircularProgressIndicator())
                  : Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        color: Kconst.backround,
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 220,
                                  mainAxisExtent: 160,
                                  childAspectRatio: 1),
                          itemBuilder: (context, index) {
                            final value = dishes[index];
                            return InkWell(
                              onTap: () {
                                ref.read(cartProvider.notifier).addCart(
                                      id: value.id,
                                      name: value.name,
                                      price: double.parse(value.price),
                                      quantity: 1,
                                    );
                              },
                              child: Card(
                                shadowColor: Kconst.green,
                                margin: const EdgeInsets.all(4),
                                color: Kconst.text3,
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
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
                                          color: const Color.fromARGB(
                                              115, 0, 0, 0),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                          softWrap: true,
                                                          maxLines: 1,
                                                          value.name),
                                                    ),
                                                    Text(
                                                        softWrap: true,
                                                        maxLines: 1,
                                                        " (Price: ${value.price})"),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    IconButton.filled(
                                                      onPressed: () {},
                                                      icon: Icon(
                                                        Icons.remove,
                                                        color: Kconst.text,
                                                      ),
                                                      style:
                                                          IconButton.styleFrom(
                                                        backgroundColor:
                                                            Kconst.red,
                                                        shape:
                                                            const ContinuousRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .all(
                                                          Radius.circular(8),
                                                        )),
                                                      ),
                                                    ),
                                                    IconButton.filled(
                                                      onPressed: () {},
                                                      icon: Icon(
                                                        Icons.add,
                                                        color: Kconst.text,
                                                      ),
                                                      style:
                                                          IconButton.styleFrom(
                                                        backgroundColor:
                                                            Kconst.green,
                                                        shape:
                                                            const ContinuousRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .all(
                                                          Radius.circular(8),
                                                        )),
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          )),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                          itemCount: dishes.length,
                        ),
                      ),
                    ),
            ],
          ),
        ),
        const Expanded(
          flex: 3,
          child: BillDetails(),
        ),
      ],
    );
  }
}
