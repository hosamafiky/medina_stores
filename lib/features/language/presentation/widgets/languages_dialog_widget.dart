part of '../presentation_imports.dart';

class LanguageDialogWidget extends StatelessWidget {
  const LanguageDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, Language>(
      builder: (context, selectedLang) {
        return ListTile(
          onTap: () async {
            final selectedLanguage = await showDialog<Language>(
              context: context,
              builder: (BuildContext context) => const _DialogWidget(),
            );

            if (selectedLanguage != null && context.mounted) {
              if (selectedLang == selectedLanguage) return;
              context.read<LanguageCubit>().changeLanguage(context, selectedLanguage);
            }
          },
          title: Text(
            selectedLang.locale.languageCode.tr(context: context),
            style: context.appTextStyle.optionalStyle.copyWith(
              fontSize: 14.sp,
            ),
          ),
          leading: const Icon(Icons.language),
          trailing: Icon(Icons.arrow_forward_ios, size: 16.sp),
        );
      },
    );
  }
}

class _DialogWidget extends StatefulWidget {
  const _DialogWidget();

  @override
  State<_DialogWidget> createState() => _DialogWidgetState();
}

class _DialogWidgetState extends State<_DialogWidget> {
  final ValueNotifier<Language> _selectedLanguage = ValueNotifier(Language.arabic);

  @override
  void initState() {
    _selectedLanguage.value = context.read<LanguageCubit>().state;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _selectedLanguage,
      builder: (context, selectedLang, child) {
        return AlertDialog(
          insetPadding: REdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          title: Text(LocaleKeys.select_language.tr()),
          content: SizedBox(
            width: 1.sw - 32.w,
            height: 0.1.sh,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: Language.values.length,
              itemBuilder: (BuildContext context, int index) {
                final language = Language.values[index];
                return ListTile(
                  contentPadding: REdgeInsets.symmetric(horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  title: Text(language.languageCode.tr()),
                  tileColor: selectedLang == language ? context.colorPalette.cardShadow : null,
                  trailing: selectedLang == language ? Icon(Icons.check_circle_outline, color: context.colorPalette.primary) : null,
                  onTap: () {
                    _selectedLanguage.value = language;
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => AppNavigator.pop(),
              child: Text(LocaleKeys.cancel.tr()),
            ),
            TextButton(
              onPressed: () => AppNavigator.pop(_selectedLanguage.value),
              child: Text(LocaleKeys.confirm.tr()),
            ),
          ],
        );
      },
    );
  }
}
