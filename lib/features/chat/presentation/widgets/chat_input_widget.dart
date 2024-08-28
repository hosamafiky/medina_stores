part of '../presentation_imports.dart';

class ChatInputField extends StatelessWidget {
  const ChatInputField({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = context.colorPalette;
    return Container(
      padding: REdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20 / 2,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 32,
            color: const Color(0xFF087949).withOpacity(0.08),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Icon(Icons.mic, color: palette.primary),
            SizedBox(width: 20.w),
            Expanded(
              child: Container(
                padding: REdgeInsets.symmetric(horizontal: 20 * 0.75),
                decoration: BoxDecoration(
                  color: palette.primary.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.sentiment_satisfied_alt_outlined,
                      color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.64),
                    ),
                    SizedBox(width: 20.h / 4),
                    const Expanded(
                      child: AppTextField(
                        hintText: "Type message",
                        isBordered: false,
                      ),
                    ),
                    Icon(
                      Icons.attach_file,
                      color: palette.primary.withOpacity(0.64),
                    ),
                    SizedBox(width: 20.h / 4),
                    Icon(
                      Icons.camera_alt_outlined,
                      color: palette.primary.withOpacity(0.64),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
