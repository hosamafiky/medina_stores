part of '../presentation_imports.dart';

class StaticPageDataWidget extends StatelessWidget {
  const StaticPageDataWidget({
    super.key,
    required this.onRetry,
  });

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<StaticPageCubit, StaticPageState, ({UsecaseStatus status, Failure? failure, String data})>(
      selector: (state) => (
        status: state.staticPagesStatus,
        failure: state.staticPagesFailure,
        data: state.staticPageData.data!,
      ),
      builder: (context, state) {
        if (state.status == UsecaseStatus.running) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }

        if (state.status == UsecaseStatus.error) {
          return ErrorViewWidget(state.failure!, onRetry: onRetry);
        }

        return SingleChildScrollView(
          padding: REdgeInsets.all(20),
          child: Html(
            data: state.data,
            onLinkTap: (url, attributes, element) {
              if (url == null) return;
              UrlLauncherHelper.launchURL(Uri.parse(url));
            },
          ),
        );
      },
    );
  }
}
