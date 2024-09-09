part of '../presentation_imports.dart';

class ChooseAddressSheet extends StatelessWidget {
  const ChooseAddressSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DependencyHelper.instance.serviceLocator<AddressCubit>()..getAddresses(),
      child: BlocSelector<AddressCubit, AddressState, ({UsecaseStatus status, Failure? failure, List<Address> addresses})>(
        selector: (state) => (status: state.addressesStatus, failure: state.addressesFailure, addresses: state.addresses),
        builder: (context, state) {
          return DraggableScrollableSheet(
            initialChildSize: 0.40, // Initial height as a fraction of the screen height
            minChildSize: 0.15, // Minimum height of the bottom sheet
            maxChildSize: 1.0, // Maximum height of the bottom sheet
            expand: false, // Allow the bottom sheet to grow based on content
            builder: (context, controller) {
              return state.status.when(
                context,
                running: (_) => _AddressesList.skeleton(controller),
                completed: (_) => _AddressesList(
                  controller,
                  addresses: state.addresses,
                ),
                error: (_) => ErrorViewWidget(
                  state.failure!,
                  onRetry: () => context.read<AddressCubit>().getAddresses(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _AddressesList extends StatelessWidget {
  const _AddressesList(this.controller, {required this.addresses}) : _isSkeleton = false;

  const _AddressesList.skeleton(this.controller)
      : _isSkeleton = true,
        addresses = const [];

  final ScrollController controller;
  final List<Address> addresses;
  final bool _isSkeleton;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: controller,
      physics: const ClampingScrollPhysics(),
      slivers: [
        SliverPadding(
          padding: REdgeInsets.all(16),
          sliver: SliverList.separated(
            itemCount: _isSkeleton ? 4 : addresses.length,
            separatorBuilder: (context, index) => SizedBox(height: 16.h),
            itemBuilder: (context, index) {
              if (_isSkeleton) {
                return ShimmerWidget.fromChild(
                  child: ListTile(
                    leading: const Text('1'),
                    title: const Text('عنوان العميل'),
                    trailing: Icon(Icons.arrow_forward_ios, size: 13.sp),
                    subtitle: const Text(
                      'عنوان العميل',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                );
              }
              final address = addresses[index];
              return AddressWidget(address);
            },
          ),
        ),
        const Divider().asSliver,
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: TextButton(
            style: TextButton.styleFrom(
              foregroundColor: context.theme.primaryColor,
              padding: REdgeInsets.all(16),
            ),
            onPressed: () async {
              final cubit = context.read<AddressCubit>();
              final address = await context.showSheet<Address>(child: const AddOrUpdateAddressSheet());
              if (address != null) {
                cubit.addAddress(AddAddressParams(address: address));
              }
            },
            child: Text(LocaleKeys.add_new_address.tr(), style: TextStyle(fontSize: 16.sp)),
          ),
        ).asSliver,
      ],
    );
  }
}
