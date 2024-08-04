import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invoice/provider/add_dishes/add_dishes.dart';

import '../provider/add_category/add_category.dart';

class AddDishes extends ConsumerStatefulWidget {
  const AddDishes({super.key});

  @override
  ConsumerState<AddDishes> createState() => _AddDishesState();
}

class _AddDishesState extends ConsumerState<AddDishes> {
  final TextEditingController name = TextEditingController();
  final TextEditingController price = TextEditingController();
  final TextEditingController discount = TextEditingController();
  final TextEditingController imageUrl = TextEditingController();
  List<String> selectedChoices = [];

  @override
  void dispose() {
    name;
    price;
    discount;
    imageUrl;
    selectedChoices;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final modelList = ref.watch(categoryListProvider).value;
    List<String> choices = modelList!.map((data) => data.category).toList();

    return AlertDialog(
      title: const Text('Add Category'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: name,
          ),
          TextField(
            controller: price,
          ),
          TextField(
            controller: discount,
          ),
          TextField(
            controller: imageUrl,
          ),
          const SizedBox(
            height: 8,
          ),
          Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: List<Widget>.generate(choices.length, (int index) {
              return ChoiceChip(
                label: Text(choices[index]),
                selected: selectedChoices.contains(choices[index]),
                onSelected: (bool selected) {
                  setState(() {
                    if (selected) {
                      selectedChoices.add(choices[index]);
                    } else {
                      selectedChoices.remove(choices[index]);
                    }
                  });
                },
              );
            }),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            String discountValue;
            if (discount.text.isEmpty) {
              discountValue = '0.0';
            } else {
              discountValue = discount.text;
            }
            ref.read(addDishesProProvider.notifier).addDishes(
                name: name.text,
                price: price.text,
                category: selectedChoices,
                discount: discountValue,
                imageUrl: imageUrl.text);
            Navigator.of(context).pop();
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
