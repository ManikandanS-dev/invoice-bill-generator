import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:invoice/constant/kconst.dart';
import 'package:invoice/provider/filter_dishes/search_bar_text.dart';

class CustomSearchBar extends ConsumerStatefulWidget {
  const CustomSearchBar({super.key});

  @override
  ConsumerState<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends ConsumerState<CustomSearchBar> {
  final TextEditingController searchBar = TextEditingController();
  @override
  void dispose() {
    searchBar;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      backgroundColor: WidgetStatePropertyAll(Kconst.text4),
      hintText: 'Search Menu',
      side: WidgetStatePropertyAll(
        BorderSide(width: 1, color: Kconst.text2),
      ),
      leading: const Icon(Icons.search),
      controller: searchBar,
      onChanged: (value) {
        ref.read(serchBarProProvider.notifier).addSearchString(searchBar.text);
      },
    );
  }
}
