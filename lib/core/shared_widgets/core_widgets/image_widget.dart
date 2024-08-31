import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../features/media_view/presentation/presentation_imports.dart';
import '../../extensions/context.dart';
import '../../navigation/navigator.dart';
import 'shimmer_widget.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    super.key,
    required this.imageUrl,
    this.height,
    this.width,
    this.borderRadius,
    this.shape = BoxShape.rectangle,
    this.isClickable = true,
  }) : assert(
          (shape == BoxShape.rectangle || (borderRadius == null && shape == BoxShape.circle)),
          'You can only use borderRadius with BoxShape.rectangle',
        );

  final String imageUrl;
  final double? height, width;
  final BorderRadiusGeometry? borderRadius;
  final BoxShape shape;
  final bool isClickable;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      errorWidget: (context, url, error) => errorWidget,
      placeholder: (context, url) => placeHolder,
      imageBuilder: (context, imageProvider) => image(imageWidget(imageProvider)),
    );
  }

  Widget get errorWidget => SizedBox(
        height: height,
        width: width,
        child: Stack(
          alignment: Alignment.center,
          children: [
            ShimmerWidget.horizontal(
              width: width,
              height: height,
              borderRadius: shape == BoxShape.circle ? BorderRadius.circular(50) : borderRadius,
            ),
            Center(
              child: Icon(
                Icons.error,
                color: AppNavigator.rootContext!.colorPalette.error,
                size: 30,
              ),
            ),
          ],
        ),
      );

  Widget get placeHolder => ShimmerWidget.horizontal(
        width: width,
        height: height,
        borderRadius: shape == BoxShape.circle ? BorderRadius.circular(50) : borderRadius,
      );

  Widget imageWidget(ImageProvider imageProvider) => GestureDetector(
        onTap: () => AppNavigator.to(ImageViewPage(imageUrl, hasHero: isClickable)),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            shape: shape,
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          ),
        ),
      );

  Widget image(Widget child) => isClickable ? Hero(tag: imageUrl, child: child) : child;
}
