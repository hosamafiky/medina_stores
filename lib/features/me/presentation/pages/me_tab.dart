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
    return BlocSelector<UserCubit, UserState, UserProfile>(
      selector: (state) => state.userProfile!.data!,
      builder: (context, data) {
        return Scaffold(
          appBar: MainAppBar(
            leadingWidth: double.maxFinite,
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
                      data.name,
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
              TextButton.icon(
                onPressed: () => AppNavigator.to(const UpdateProfilePage()),
                icon: Icon(Icons.arrow_forward_ios, size: 14.sp),
                iconAlignment: IconAlignment.end,
                label: Text(
                  LocaleKeys.edit.tr(context: context),
                  style: TextStyle(color: context.colorPalette.primary),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: REdgeInsets.all(16.0),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AccountSection(),
                HelpSection(),
              ],
            ),
          ),
        );
      },
    );
  }
}
