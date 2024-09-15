part of '../presentation_imports.dart';

class AccountSection extends StatelessWidget {
  const AccountSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
                child: BlocSelector<UserCubit, UserState, num>(
                  selector: (state) => state.userProfile?.data?.wallet ?? 0,
                  builder: (context, wallet) {
                    return Text(
                      '$wallet ${LocaleKeys.shorten_currency.tr(context: context)} ',
                      style: context.appTextStyle.elevatedButtonTextStyle.copyWith(
                        fontSize: 14.sp,
                      ),
                    );
                  },
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 16.sp),
            ],
          ).withSpacing(spacing: 6.w),
        ),
        ListTile(
          onTap: () => AppNavigator.to(const AddressesPage()),
          title: Text(
            LocaleKeys.my_addresses.tr(context: context),
            style: context.appTextStyle.optionalStyle.copyWith(
              fontSize: 14.sp,
            ),
          ),
          leading: const Icon(Icons.location_on),
          trailing: Icon(Icons.arrow_forward_ios, size: 16.sp),
        ),
        ListTile(
          onTap: () => AppNavigator.to(const FavoriteProducts()),
          title: Text(
            LocaleKeys.favorite_products.tr(context: context),
            style: context.appTextStyle.optionalStyle.copyWith(
              fontSize: 14.sp,
            ),
          ),
          leading: const Icon(Icons.favorite_outline_rounded),
          trailing: Icon(Icons.arrow_forward_ios, size: 16.sp),
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
      ],
    );
  }
}
