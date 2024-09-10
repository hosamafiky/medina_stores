part of '../presentation_imports.dart';

class MeTab extends StatefulWidget {
  const MeTab({super.key});

  @override
  State<MeTab> createState() => _MeTabState();
}

class _MeTabState extends State<MeTab> {
  @override
  void initState() {
    context.read<UserCubit>().getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MePageListener(
      child: BlocSelector<UserCubit, UserState, UserProfile>(
        selector: (state) => state.userProfile!.data!,
        builder: (context, data) {
          return Scaffold(
            appBar: MainAppBar(
              leadingWidth: 180.w,
              toolbarHeight: 60.h,
              leading: Row(
                children: [
                  SizedBox(width: 10.w),
                  CircleAvatar(
                    radius: 20.w,
                    child: Text(data.abbrev),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        data.name.capitalize,
                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${data.dialingCode} ${data.phone}',
                        textDirection: TextDirection.ltr,
                      ),
                    ],
                  ),
                ],
              ).withSpacing(spacing: 6.w),
              actions: [
                TextButton(
                  onPressed: () => AppNavigator.to(const ProfilePage()),
                  child: Text(
                    LocaleKeys.edit.tr(),
                    style: TextStyle(color: context.colorPalette.primary),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () => context.read<UserCubit>().logout(),
                ),
              ],
            ),
            body: Padding(
              padding: REdgeInsets.all(16.0),
              child: Column(
                children: [
                  ListTile(
                    onTap: () => AppNavigator.to(const ProfilePage()),
                    title: Text(
                      LocaleKeys.profile.tr(),
                      style: context.appTextStyle.optionalStyle.copyWith(
                        fontSize: 14.sp,
                      ),
                    ),
                    leading: const Icon(Icons.person),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16.sp),
                  ),
                  ListTile(
                    onTap: () => AppNavigator.to(const ProfilePage()),
                    title: Text(
                      LocaleKeys.wallet.tr(),
                      style: context.appTextStyle.optionalStyle.copyWith(
                        fontSize: 14.sp,
                      ),
                    ),
                    leading: const Icon(Icons.person),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: REdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: context.colorPalette.secondary,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                            '${data.wallet} ${LocaleKeys.shorten_currency.tr()} ',
                            style: context.appTextStyle.elevatedButtonTextStyle.copyWith(
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios, size: 16.sp),
                      ],
                    ).withSpacing(spacing: 6.w),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
