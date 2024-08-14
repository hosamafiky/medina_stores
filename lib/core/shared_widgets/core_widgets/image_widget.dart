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
    this.shape = BoxShape.rectangle,
  }) : assert(
          (shape == BoxShape.rectangle || (borderRadius == null && shape == BoxShape.circle)),
          'You can only use borderRadius with BoxShape.rectangle',
        );

  final String imageUrl;
  final double? height, width;
  final BorderRadiusGeometry? borderRadius;
  final BoxShape shape;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      errorWidget: (context, url, error) => errorWidget,
      placeholder: (context, url) => placeHolder,
      imageBuilder: (context, imageProvider) => imageWidget,
    );
  }

  Widget get errorWidget => Stack(
        children: [
          ShimmerWidget.horizontal(
            width: width,
            height: height,
            borderRadius: borderRadius,
          ),
          const Center(
            child: Icon(
              Icons.error,
              color: Colors.red,
              size: 30,
            ),
          ),
        ],
      );

  Widget get placeHolder => ShimmerWidget.horizontal(
        width: width,
        height: height,
        borderRadius: borderRadius,
      );

  Widget get imageWidget => CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        errorWidget: (context, url, error) => errorWidget,
        placeholder: (context, url) => placeHolder,
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
