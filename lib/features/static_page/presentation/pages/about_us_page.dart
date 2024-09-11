part of '../presentation_imports.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DependencyHelper.instance.serviceLocator<StaticPageCubit>()..getStaticPage(ApiConstants.endPoints.ABOUT),
      child: const AboutUsBody(),
    );
  }
}

class AboutUsBody extends StatelessWidget {
  const AboutUsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: Text(LocaleKeys.about_us.tr()),
      ),
      body: StaticPageDataWidget(
        onRetry: () {
          context.read<StaticPageCubit>().getStaticPage(ApiConstants.endPoints.ABOUT);
        },
      ),
    );
  }
}
