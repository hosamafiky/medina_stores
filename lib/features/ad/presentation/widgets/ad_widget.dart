part of '../presentation_imports.dart';

class AdWidget extends StatelessWidget {
  const AdWidget(this.ad, {super.key});

  final Ad ad;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async => await UrlLauncherHelper.launchURL(Uri.parse(ad.url)),
      child: _buildAdWidget(),
    );
  }

  Widget _buildAdWidget() {
    switch (ad.type) {
      case MediaType.image:
        return ImageWidget(
          imageUrl: ad.media,
          borderRadius: BorderRadius.circular(10.r),
          height: 120.h,
        );
      case MediaType.video:
        return VideoWidget(mediaUrl: ad.media);
    }
  }
}
