part of '../presentation_imports.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DependencyHelper.instance.serviceLocator<StaticPageCubit>()..getStaticPage(ApiConstants.endPoints.TERMS),
      child: const TermsBody(),
    );
  }
}

class TermsBody extends StatelessWidget {
  const TermsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: Text(LocaleKeys.terms_and_conditions.tr()),
      ),
      body: StaticPageDataWidget(
        onRetry: () {
          context.read<StaticPageCubit>().getStaticPage(ApiConstants.endPoints.TERMS);
        },
      ),
    );
  }
}
