part of '../presentation_imports.dart';

class AdsPage extends StatelessWidget {
  const AdsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DependencyHelper.instance.get<AdCubit>()..getAds(),
      child: const AdsPageBody(),
    );
  }
}

class AdsPageBody extends StatefulWidget {
  const AdsPageBody({super.key});

  @override
  State<AdsPageBody> createState() => _AdsPageBodyState();
}

class _AdsPageBodyState extends State<AdsPageBody> {
  final _scrollController = ScrollController();

  void _onScroll() {
    final currentScroll = _scrollController.position.pixels;
    final maxScroll = _scrollController.position.maxScrollExtent;

    if (currentScroll == maxScroll) {
      context.read<AdCubit>().getAds();
    }
  }

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(),
      body: BlocSelector<AdCubit, AdState, ({UsecaseStatus status, Failure? failure, PaginatedList<Ad> ads})>(
        selector: (state) => (status: state.adsStatus, failure: state.adsFailure, ads: state.ads.data!),
        builder: (context, state) {
          return state.status.when(
            context,
            idle: (context) => const Center(child: CircularProgressIndicator.adaptive()),
            running: (context) => const Center(child: CircularProgressIndicator.adaptive()),
            completed: (context) => ListView.separated(
              controller: _scrollController,
              itemCount: !state.ads.hasReachedEnd ? state.ads.data.length + 1 : state.ads.data.length,
              separatorBuilder: (context, index) => SizedBox(height: 16.h),
              itemBuilder: (context, index) {
                if (index >= state.ads.data.length) {
                  return const Center(child: CircularProgressIndicator());
                }

                final ad = state.ads.data[index];
                return AdWidget(ad);
              },
            ),
            error: (context) => Center(child: Text(state.failure!.response.message)),
          );
        },
      ),
    );
  }
}
