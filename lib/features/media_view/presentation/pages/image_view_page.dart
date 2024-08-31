part of '../presentation_imports.dart';

class ImageViewPage extends StatelessWidget {
  const ImageViewPage(this.imageUrl, {super.key, this.hasHero = false});

  final String imageUrl;
  final bool hasHero;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const MainAppBar(
        backgroundColor: Colors.transparent,
        iconColor: ColorPalette.whiteColor,
      ),
      body: PhotoView(
        heroAttributes: hasHero ? PhotoViewHeroAttributes(tag: imageUrl) : null,
        imageProvider: CachedNetworkImageProvider(imageUrl),
      ),
    );
  }
}
