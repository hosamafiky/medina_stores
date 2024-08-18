part of '../presentation_imports.dart';

class AdDotsIndicator extends StatelessWidget {
  const AdDotsIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final palette = context.colorPalette;
    return BlocBuilder<AdCubit, AdState>(
      builder: (context, state) {
        return ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 0.7.sw,
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final maxWidth = constraints.maxWidth;
              final width = maxWidth / state.ads.data!.data.length;
              final spacing = 0.01.sw;
              final dotWidth = width - spacing;

              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  state.ads.data!.data.length,
                  (index) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: state.adIndex == index ? dotWidth : dotWidth * 0.8,
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: state.adIndex == index ? palette.currentAdDotColor : palette.otherAdDotColor,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    );
                  },
                ),
              ).withSpacing(spacing: spacing);
            },
          ),
        );
      },
    );
  }
}
