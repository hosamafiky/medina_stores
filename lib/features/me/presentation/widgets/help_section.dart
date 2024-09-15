part of '../presentation_imports.dart';

class HelpSection extends StatelessWidget {
  const HelpSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
    );
  }
}
