part of '../presentation_imports.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(
        title: Text('الملف الشخصي'),
        centerTitle: true,
      ),
      body: BlocSelector<UserCubit, UserState, UserProfile>(
        selector: (state) => state.userProfile!.data!,
        builder: (context, data) {
          return Padding(
            padding: REdgeInsets.all(16),
            child: Column(
              children: [
                AppTextField.withLabel(
                  label: LocaleKeys.first_name.tr(),
                  controller: TextEditingController(text: data.firstName),
                  readOnly: true,
                  prefixIcon: const Icon(Icons.person),
                ),
                AppTextField.withLabel(
                  label: LocaleKeys.last_name.tr(),
                  controller: TextEditingController(text: data.lastName),
                  readOnly: true,
                  prefixIcon: const Icon(Icons.person),
                ),
                AppTextField.withLabel(
                  label: LocaleKeys.email.tr(),
                  controller: TextEditingController(text: data.email),
                  readOnly: true,
                  prefixIcon: const Icon(Icons.email),
                ),
                AppTextField.withLabel(
                  label: LocaleKeys.phone.tr(),
                  controller: TextEditingController(text: data.phone),
                  readOnly: true,
                  prefixIcon: const Icon(Icons.phone),
                ),
                ListTile(
                  title: const Text('تغيير كلمة المرور'),
                  leading: const Icon(Icons.lock),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16.sp),
                ),
              ],
            ).withSpacing(spacing: 16.h),
          );
        },
      ),
    );
  }
}
