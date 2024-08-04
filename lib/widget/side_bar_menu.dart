import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invoice/constant/kconst.dart';
import 'package:invoice/provider/side_menu_button/menu_button_int.dart';

import '../model/side_menu_button.dart';
import '../provider/auth_provider/auth_provider.dart';

class SideBarMenu extends ConsumerWidget {
  const SideBarMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectindex = ref.watch(menuButtonIntProvider);

    return Container(
      width: Kconst.isMini(context) ? 200 : 230,
      decoration: BoxDecoration(
        gradient: Kconst.linearBackroundDark2,
        border: Border.all(width: 1, color: Kconst.text3),
        borderRadius: const BorderRadius.all(
          Radius.circular(2),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          Expanded(
            child: ListView.builder(
                itemBuilder: (context, index) {
                  final button = sideMenuButton[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: InkWell(
                      onTap: () {
                        ref.read(menuButtonIntProvider.notifier).state = index;
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: index == selectindex
                              ? Kconst.green2
                              : Kconst.text4,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        height: 50,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: 14,
                            ),
                            Icon(
                              button.icon,
                              color: index == selectindex
                                  ? Kconst.text4
                                  : Kconst.text,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              button.tittle,
                              style: Kconst.kTextTheme(context)
                                  .titleMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: index == selectindex
                                        ? Kconst.text4
                                        : Kconst.text,
                                  ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: sideMenuButton.length),
          ),
          FilledButton.icon(
            style: FilledButton.styleFrom(
              fixedSize: const Size(180, 60),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              backgroundColor: Kconst.red,
            ),
            icon: Icon(
              Icons.logout,
              color: Kconst.text,
            ),
            onPressed: () {
              ref.read(authRepoProvider).sinOut();
            },
            label: Text(
              'Logout',
              style: Kconst.kTextTheme(context).titleLarge,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }
}
