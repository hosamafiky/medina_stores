part of '../presentation_imports.dart';

class AddressesPage extends StatelessWidget {
  const AddressesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DependencyHelper.instance.get<AddressCubit>()..getAddresses(),
      child: const AddressesPageBody(),
    );
  }
}

class AddressesPageBody extends StatelessWidget {
  const AddressesPageBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(title: Text(LocaleKeys.my_addresses.tr())),
      body: BlocSelector<AddressCubit, AddressState, ({UsecaseStatus status, Failure? failure, List<Address> addresses})>(
        selector: (state) => (status: state.addressesStatus, failure: state.addressesFailure, addresses: state.addresses),
        builder: (context, state) {
          return ListView.separated(
            padding: REdgeInsets.all(16),
            itemCount: state.addresses.length,
            separatorBuilder: (context, index) => SizedBox(height: 16.h),
            itemBuilder: (context, index) {
              final address = state.addresses[index];
              return ListTile(
                leading: Text(address.id.toString()),
                title: Text(address.title),
                subtitle: Text(
                  address.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final cubit = context.read<AddressCubit>();
          final response = await context.showSheet<Address>(
            child: const AddOrUpdateAddressSheet(),
            isScrollControlled: true,
          );
          if (response != null) {
            final params = AddAddressParams(address: response);
            cubit.addAddress(params);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
