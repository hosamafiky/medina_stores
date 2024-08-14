import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:medina_stores/core/shared_widgets/core_widgets/shimmer_widget.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    super.key,
    required this.imageUrl,
    this.height,
    this.width,
    this.borderRadius,
  });

  final String imageUrl;
  final double? height, width;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      errorWidget: (context, url, error) => const Icon(Icons.error),
      placeholder: (context, url) => ShimmerWidget.horizontal(
        width: width,
        height: height,
        borderRadius: borderRadius,
      ),
      imageBuilder: (context, imageProvider) => Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
