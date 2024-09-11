part of '../presentation_imports.dart';

class AppLicensePage extends StatelessWidget {
  const AppLicensePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DependencyHelper.instance.serviceLocator<StaticPageCubit>()..getStaticPage(ApiConstants.endPoints.LICENSE),
      child: const LicenseBody(),
    );
  }
}

class LicenseBody extends StatelessWidget {
  const LicenseBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: Text(LocaleKeys.license.tr()),
      ),
      body: StaticPageDataWidget(
        onRetry: () {
          context.read<StaticPageCubit>().getStaticPage(ApiConstants.endPoints.LICENSE);
        },
      ),
    );
  }
}
