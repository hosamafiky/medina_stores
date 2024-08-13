part of '../presentation_imports.dart';

class LanguagesDropdownWidget extends StatelessWidget {
  const LanguagesDropdownWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, Language>(
      builder: (context, state) {
        return SizedBox(
          width: 100,
          child: DropdownButton<Language>(
            value: state,
            onChanged: (language) {
              if (language == null) return;
              context.read<LanguageCubit>().changeLanguage(context, language);
            },
            items: Language.values
                .map(
                  (language) => DropdownMenuItem<Language>(
                    value: language,
                    child: Text(language.locale.languageCode.tr(context: context)),
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }
}
