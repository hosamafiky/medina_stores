import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/resources/color_palettes/color_palette.dart';
import '../../extensions/context.dart';

class ConnectivityManager extends StatefulWidget {
  final Widget child;
  const ConnectivityManager({super.key, required this.child});

  @override
  State<ConnectivityManager> createState() => _ConnectivityManagerState();
}

class _ConnectivityManagerState extends State<ConnectivityManager> {
  bool isCurrentlyConnected = false;

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
      connectivityBuilder: (
        BuildContext context,
        List<ConnectivityResult> connectivity,
        Widget item,
      ) {
        bool connected = !connectivity.contains(ConnectivityResult.none);
        isCurrentlyConnected = connected;
        if (connected != isCurrentlyConnected) {
          log("Connectivity: $connectivity");
        }
        if (!connected) {
          FocusScope.of(context).unfocus();
        }
        return Stack(
          fit: StackFit.expand,
          children: [
            item,
            Positioned(
              right: 0,
              left: 0,
              child: AnimatedContainer(
                padding: REdgeInsets.all(16).copyWith(top: context.statusBarHeight),
                duration: const Duration(milliseconds: 500),
                color: connected ? Colors.green : Colors.red,
                height: !connected ? 50.h + context.statusBarHeight : 0,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      connected = true;
                    });
                  },
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
            ),
          ],
        );
      },
      builder: (BuildContext context) => widget.child,
    );
  }
}
