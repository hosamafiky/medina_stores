part of '../presentation_imports.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({super.key});

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void initState() {
    final user = context.read<UserCubit>().state.userProfile!.data!;
    _firstNameController.text = user.firstName;
    _lastNameController.text = user.lastName;
    _emailController.text = user.email;
    _phoneController.text = user.phone;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: Text(LocaleKeys.profile.tr()),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_remove_outlined),
            onPressed: () => context.read<UserCubit>().deleteAccount(),
          ),
          IconButton(
            icon: const Icon(Icons.logout_rounded),
            onPressed: () => context.read<UserCubit>().logout(),
          ),
        ],
      ),
      body: UpdateProfilePageListener(
        onProfileUpdated: (profile) {
          _firstNameController.text = profile.firstName;
          _lastNameController.text = profile.lastName;
          _emailController.text = profile.email;
          _phoneController.text = profile.phone;
        },
        child: BlocSelector<UserCubit, UserState, UserProfile>(
          selector: (state) => state.userProfile!.data!,
          builder: (context, data) {
            return Padding(
              padding: REdgeInsets.all(16),
              child: Column(
                children: [
                  AppTextField.withLabel(
                    label: LocaleKeys.first_name.tr(),
                    controller: _firstNameController,
                    prefixIcon: const Icon(Icons.person),
                    keyboardType: TextInputType.name,
                    validator: (value) => ValidationHelper.validateName(value, LocaleKeys.first_name.tr()),
                  ),
                  AppTextField.withLabel(
                    label: LocaleKeys.last_name.tr(),
                    controller: _lastNameController,
                    prefixIcon: const Icon(Icons.person),
                    keyboardType: TextInputType.name,
                    validator: (value) => ValidationHelper.validateName(value, LocaleKeys.last_name.tr()),
                  ),
                  AppTextField.withLabel(
                    label: LocaleKeys.email.tr(),
                    controller: _emailController,
                    prefixIcon: const Icon(Icons.email),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => ValidationHelper.validateEmail(value),
                  ),
                  AppTextField.withLabel(
                    label: LocaleKeys.phone.tr(),
                    controller: _phoneController,
                    prefixIcon: const Icon(Icons.phone),
                    keyboardType: TextInputType.phone,
                    validator: (value) => ValidationHelper.validatePhoneNumber(value),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final params = UpdateProfileParams(
                        firstName: _firstNameController.text == data.firstName ? null : _firstNameController.text,
                        lastName: _lastNameController.text == data.lastName ? null : _lastNameController.text,
                        email: _emailController.text == data.email ? null : _emailController.text,
                        phone: _phoneController.text == data.phone ? null : _phoneController.text,
                      );
                      context.read<UserCubit>().updateProfile(params);
                    },
                    child: Text(LocaleKeys.update.tr()),
                  ),
                ],
              ).withSpacing(spacing: 16.h),
            );
          },
        ),
      ),
    );
  }
}
