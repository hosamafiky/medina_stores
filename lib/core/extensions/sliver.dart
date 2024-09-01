import 'package:flutter/material.dart';

extension SliverX on Widget {
  Widget get asSliver {
    return SliverToBoxAdapter(child: this);
  }
}
