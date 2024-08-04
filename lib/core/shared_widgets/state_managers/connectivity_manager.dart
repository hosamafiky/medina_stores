import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medina_stores/core/extentions/context.dart';

import '../../../config/resources/color_palettes/color_palette.dart';

class ConnectivityManager extends StatefulWidget {
  final Widget child;
  const ConnectivityManager({super.key, required this.child});

  @override
  State<ConnectivityManager> createState() => _ConnectivityManagerState();
}

class _ConnectivityManagerState extends State<ConnectivityManager> with TickerProviderStateMixin {
  bool connected = false;

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
      connectivityBuilder: (
        BuildContext context,
        List<ConnectivityResult> connectivity,
        Widget item,
      ) {
        final bool connected = !connectivity.contains(ConnectivityResult.none);
        if (!connected) {
          FocusScope.of(context).unfocus();
        }
        return Stack(
          fit: StackFit.expand,
          children: [
            IgnorePointer(ignoring: !connected, child: item),
            Positioned(
              right: 0,
              left: 0,
              child: AnimatedContainer(
                padding: REdgeInsets.all(16).copyWith(top: context.statusBarHeight),
                duration: const Duration(milliseconds: 500),
                color: connected ? Colors.green : Colors.red,
                height: !connected ? 50.h + context.statusBarHeight : 0,
                child: Center(
                  child: Text(
                    connected ? 'Online' : 'Offline',
                    style: const TextStyle(
                      color: ColorPalette.whiteColor,
                      fontSize: 20,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
      builder: (BuildContext context) => widget.child,
    );
  }
}
