part of '../presentation_imports.dart';

class AddressWidget extends StatelessWidget {
  const AddressWidget(this.address, {super.key});

  final Address address;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => AppNavigator.pop(address),
      leading: Text(address.id.toString()),
      title: Text(address.title),
      trailing: Icon(Icons.arrow_forward_ios, size: 13.sp),
      subtitle: Text(
        address.title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
