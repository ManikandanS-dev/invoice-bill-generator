import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constant/kconst.dart';
import '../provider/add_category/add_category.dart';
import '../provider/add_dishes/add_dishes.dart';
import '../widget/home_body.dart';

import '../widget/side_bar_menu.dart';
import '../widget/windows_headter.dart';

class HomeScr extends ConsumerWidget {
  HomeScr({super.key});
  final _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(categoryListProvider);
    ref.watch(addDishesProProvider);

    return Scaffold(
      key: _key,
      drawer: const SideBarMenu(),
      backgroundColor: Kconst.backround,
      body: WindowBorder(
        color: Kconst.borderColor,
        width: Kconst.borderWith,
        child: Column(
          children: [
            Row(
              children: [
                if (Kconst.isMini(context))
                  IconButton(
                    onPressed: () {
                      _key.currentState!.openDrawer();
                    },
                    icon: const Icon(Icons.toc),
                  ),
                const Expanded(child: WindowsHeadter()),
              ],
            ),
            Expanded(
              child: Row(
                children: [
                  if (!Kconst.isMini(context)) const SideBarMenu(),
                  const Expanded(
                    child: Column(
                      children: [
                        HomeBody(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
