import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invoice/constant/kconst.dart';
import 'package:invoice/provider/side_menu_button/menu_button_int.dart';

import '../screen/billing_scr.dart';
import '../screen/manage_dishes_scr.dart';

class HomeBody extends ConsumerWidget {
  const HomeBody({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget body = const Text('home');

    final selectInt = ref.watch(menuButtonIntProvider);
    if (1 == selectInt) {
      body = const BillingScr();
    }
    if (2 == selectInt) {
      body = const ManageDishes();
    }
    if (3 == selectInt) {
      body = const Text('oder history');
    }

    return Expanded(
      flex: 14,
      child: Container(
        width: double.infinity,
        color: Kconst.kTheme(context).onSecondary,
        child: body,
      ),
    );
  }
}
