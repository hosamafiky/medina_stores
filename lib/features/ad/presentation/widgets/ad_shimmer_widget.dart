part of '../presentation_imports.dart';

class AdShimmerWidget extends StatelessWidget {
  const AdShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 10),
      child: const ShimmerWidget.horizontal(height: 90),
    );
  }
}
