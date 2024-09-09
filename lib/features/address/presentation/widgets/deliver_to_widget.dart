part of '../presentation_imports.dart';

class DeliverToWidget extends StatelessWidget {
  const DeliverToWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AddressCubit, AddressState, Address?>(
      selector: (state) => state.selectedAddress,
      builder: (context, state) {
        if (state == null) return const SizedBox();
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(LocaleKeys.deliver_to.tr(), style: TextStyle(fontSize: 12.sp)),
            InkWell(
              onTap: () async {
                if (context.isLoggedIn) {
                  final result = await context.showSheet(child: const ChooseAddressSheet());
                  if (result != null && context.mounted) {
                    context.read<AddressCubit>().selectAddress(result);
                  }
                } else {
                  await context.showSheet(child: VisitorLoginSheet(
                    onLoggedInCallback: () async {
                      final result = await context.showSheet(child: const ChooseAddressSheet());
                      if (result != null && context.mounted) {
                        context.read<AddressCubit>().selectAddress(result);
                      }
                    },
                  ));
                }
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    state.title,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
