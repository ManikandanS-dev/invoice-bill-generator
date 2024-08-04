import 'package:bitsdojo_window/bitsdojo_window.dart' as win;
import 'package:flutter/material.dart';

import '../constant/kconst.dart';

class WindowsHeadter extends StatelessWidget {
  const WindowsHeadter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return win.WindowTitleBarBox(
      child: Row(
        children: [
          Expanded(
            child: win.MoveWindow(
              child: Container(
                decoration: BoxDecoration(
                    color: Kconst.backround,
                    border: Border.all(color: Kconst.text2, width: 1)),
              ),
            ),
          ),
          win.MinimizeWindowButton(
            colors: win.WindowButtonColors(
                normal: Kconst.green2, iconNormal: Kconst.text),
          ),
          win.MaximizeWindowButton(
            colors: win.WindowButtonColors(
              normal: Kconst.yellow2,
              iconNormal: Kconst.text,
            ),
          ),
          win.CloseWindowButton(
            colors: win.WindowButtonColors(
                normal: Kconst.red2, iconNormal: Kconst.text),
          ),
        ],
      ),
    );
  }
}
