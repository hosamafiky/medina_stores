part of '../presentation_imports.dart';

class AddressWidget extends StatelessWidget {
  const AddressWidget(this.address, {super.key});

  final Address address;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: () => AppNavigator.pop(address),
      leading: Icon(
        Icons.location_history,
        color: context.colorPalette.accent,
      ),
      title: Text(address.title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(context.colorPalette.success),
            ),
            icon: const Icon(
              Icons.edit,
              color: ColorPalette.whiteColor,
            ),
            onPressed: () async {
              final cubit = context.read<AddressCubit>();
              final updatedAddress = await context.showSheet<Address>(child: AddAddressSheet.update(address: address));
              if (updatedAddress != null) {
                final params = UpdateAddressParams(address: updatedAddress);
                cubit.updateAddress(params);
              }
            },
          ),
          IconButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(context.colorPalette.error.withOpacity(0.1)),
            ),
            icon: Icon(
              Icons.delete,
              color: context.colorPalette.error,
            ),
            onPressed: () async {},
          ),
        ],
      ),
      subtitle: Text(
        "${address.latitude.toStringAsFixed(2)}, ${address.longitude.toStringAsFixed(2)}",
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
