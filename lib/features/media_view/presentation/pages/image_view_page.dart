part of '../presentation_imports.dart';

class ImageViewPage extends StatelessWidget {
  const ImageViewPage(this.imageUrl, {super.key});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const MainAppBar(
        backgroundColor: Colors.transparent,
        iconColor: ColorPalette.whiteColor,
      ),
      body: PhotoView(
        heroAttributes: PhotoViewHeroAttributes(tag: imageUrl),
        imageProvider: CachedNetworkImageProvider(imageUrl),
      ),
    );
  }
}
