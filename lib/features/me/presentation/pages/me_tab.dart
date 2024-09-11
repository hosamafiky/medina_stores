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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: REdgeInsets.all(16.0),
                  child: Text(
                    LocaleKeys.account.tr(context: context),
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListTile(
                  title: Text(
                    LocaleKeys.wallet.tr(context: context),
                    style: context.appTextStyle.optionalStyle.copyWith(
                      fontSize: 14.sp,
                    ),
                  ),
                  leading: const Icon(Icons.wallet),
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
                          '${data.wallet} ${LocaleKeys.shorten_currency.tr(context: context)} ',
                          style: context.appTextStyle.elevatedButtonTextStyle.copyWith(
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios, size: 16.sp),
                    ],
                  ).withSpacing(spacing: 6.w),
                ),
                ListTile(
                  onTap: () => AppNavigator.to(const ChangePasswordPage()),
                  title: Text(
                    LocaleKeys.change_password.tr(context: context),
                    style: context.appTextStyle.optionalStyle.copyWith(
                      fontSize: 14.sp,
                    ),
                  ),
                  leading: const Icon(Icons.lock),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16.sp),
                ),
                const LanguageDialogWidget(),
                Padding(
                  padding: REdgeInsets.all(16.0),
                  child: Text(
                    LocaleKeys.help.tr(context: context),
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListTile(
                  onTap: () => AppNavigator.to(const PrivacyPolicyPage()),
                  title: Text(
                    LocaleKeys.privacy_policy.tr(context: context),
                    style: context.appTextStyle.optionalStyle.copyWith(
                      fontSize: 14.sp,
                    ),
                  ),
                  leading: const Icon(Icons.privacy_tip),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16.sp),
                ),
                ListTile(
                  onTap: () => AppNavigator.to(const ShippingPolicyPage()),
                  title: Text(
                    LocaleKeys.shipping_policy.tr(context: context),
                    style: context.appTextStyle.optionalStyle.copyWith(
                      fontSize: 14.sp,
                    ),
                  ),
                  leading: const Icon(Icons.privacy_tip),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16.sp),
                ),
                ListTile(
                  onTap: () => AppNavigator.to(const TermsPage()),
                  title: Text(
                    LocaleKeys.terms_and_conditions.tr(context: context),
                    style: context.appTextStyle.optionalStyle.copyWith(
                      fontSize: 14.sp,
                    ),
                  ),
                  leading: const Icon(Icons.privacy_tip),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16.sp),
                ),
                ListTile(
                  onTap: () => AppNavigator.to(const AboutUsPage()),
                  title: Text(
                    LocaleKeys.about_us.tr(context: context),
                    style: context.appTextStyle.optionalStyle.copyWith(
                      fontSize: 14.sp,
                    ),
                  ),
                  leading: const Icon(Icons.privacy_tip),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16.sp),
                ),
                ListTile(
                  onTap: () => AppNavigator.to(const ContactUsPage()),
                  title: Text(
                    LocaleKeys.contact_us.tr(context: context),
                    style: context.appTextStyle.optionalStyle.copyWith(
                      fontSize: 14.sp,
                    ),
                  ),
                  leading: const Icon(Icons.privacy_tip),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16.sp),
                ),
                ListTile(
                  onTap: () => AppNavigator.to(const AppLicensePage()),
                  title: Text(
                    LocaleKeys.license.tr(context: context),
                    style: context.appTextStyle.optionalStyle.copyWith(
                      fontSize: 14.sp,
                    ),
                  ),
                  leading: const Icon(Icons.privacy_tip),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16.sp),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
