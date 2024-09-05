part of '../presentation_imports.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DependencyHelper.instance.get<ProfileCubit>()..getProfiles(),
      child: const ProfileTabBody(),
    );
  }
}

class ProfileTabBody extends StatelessWidget {
  const ProfileTabBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfilePageListener(
      child: Scaffold(
        appBar: MainAppBar(
          title: Text(LocaleKeys.profile.tr(context: context)),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              context.read<UserCubit>().logout();
            },
            icon: const Icon(Icons.logout_rounded),
          ),
          padEnd: true,
          actions: [
            IconButton(
              onPressed: () => AppNavigator.to(const FavoriteProducts()),
              icon: const Icon(
                CupertinoIcons.heart_fill,
                color: Colors.redAccent,
              ),
            ),
          ],
        ),
        body: Padding(
          padding: REdgeInsets.symmetric(horizontal: 16.0),
          child: BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              if (state.user?.data == null) {
                return const Center(child: CircularProgressIndicator.adaptive());
              }

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Current User Data"),
                  Text(state.user!.data!.modelize.toMap().prettify),
                  const LanguagesDropdownWidget(),
                ],
              ).withSpacing(spacing: 16.h);
            },
          ),
        ),
      ),
    );
  }
}
