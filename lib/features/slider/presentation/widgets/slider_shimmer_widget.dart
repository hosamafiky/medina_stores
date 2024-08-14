part of '../presentation_imports.dart';

class SliderShimmerWidget extends StatelessWidget {
  const SliderShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const ShimmerWidget.horizontal(width: 150, height: 90);
  }
}
