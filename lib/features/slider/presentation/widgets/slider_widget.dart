part of '../presentation_imports.dart';

class SliderWidget extends StatelessWidget {
  const SliderWidget(this.slider, {super.key});

  final Slider slider;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 10),
      child: _buildSliderWidget(),
    );
  }

  Widget _buildSliderWidget() {
    switch (slider.type) {
      case SliderMediaType.image:
        return ImageWidget(
          imageUrl: slider.media,
          borderRadius: BorderRadius.circular(10.r),
          height: 150.h,
        );
      case SliderMediaType.video:
        return VideoWidget(mediaUrl: slider.media);
    }
  }
}
