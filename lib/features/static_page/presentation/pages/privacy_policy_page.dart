part of '../presentation_imports.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DependencyHelper.instance.serviceLocator<StaticPageCubit>()..getStaticPage(ApiConstants.endPoints.PRIVACY),
      child: const PrivacyPolicyBody(),
    );
  }
}

class PrivacyPolicyBody extends StatelessWidget {
  const PrivacyPolicyBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: Text(LocaleKeys.privacy_policy.tr()),
      ),
      body: StaticPageDataWidget(
        onRetry: () {
          context.read<StaticPageCubit>().getStaticPage(ApiConstants.endPoints.PRIVACY);
        },
      ),
    );
  }
}
