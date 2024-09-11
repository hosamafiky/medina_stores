part of '../presentation_imports.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DependencyHelper.instance.serviceLocator<StaticPageCubit>()..getStaticPage(ApiConstants.endPoints.CONTACT),
      child: const ContactUsBody(),
    );
  }
}

class ContactUsBody extends StatelessWidget {
  const ContactUsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: Text(LocaleKeys.about_us.tr()),
      ),
      body: StaticPageDataWidget(
        onRetry: () {
          context.read<StaticPageCubit>().getStaticPage(ApiConstants.endPoints.CONTACT);
        },
      ),
    );
  }
}
