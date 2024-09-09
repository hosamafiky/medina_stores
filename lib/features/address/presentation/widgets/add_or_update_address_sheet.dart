part of '../presentation_imports.dart';

class AddOrUpdateAddressSheet extends StatefulWidget {
  const AddOrUpdateAddressSheet({super.key}) : address = null;

  const AddOrUpdateAddressSheet.update({super.key, required this.address});

  final Address? address;
  @override
  State<AddOrUpdateAddressSheet> createState() => _AddOrUpdateAddressSheetState();
}

class _AddOrUpdateAddressSheetState extends State<AddOrUpdateAddressSheet> {
  final _formKey = GlobalKey<FormState>();
  ValueNotifier<LatLng?> selectedLocation = ValueNotifier(null);
  final _titleController = TextEditingController();

  @override
  void initState() {
    getInitialPosition();
    super.initState();
  }

  void getInitialPosition() async {
    if (widget.address != null) {
      selectedLocation.value = LatLng(widget.address!.latitude, widget.address!.longitude);
      _titleController.text = widget.address!.title;
      return;
    }
    final position = await LocationHelper.getCurrentPosition();
    if (position == null) {
      AppNavigator.pop();
      return;
    }
    selectedLocation.value = LatLng(position.latitude, position.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DependencyHelper.instance.serviceLocator<AddressCubit>(),
      child: BlocBuilder<AddressCubit, AddressState>(
        builder: (context, state) {
          return Padding(
            padding: REdgeInsets.all(16.0).copyWith(
              bottom: context.bottomBarHeight + 16.h,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 200.h,
                    child: ValueListenableBuilder(
                      valueListenable: selectedLocation,
                      builder: (context, LatLng? value, child) {
                        if (value == null) return const Center(child: CircularProgressIndicator.adaptive());
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(16.r),
                          child: GoogleMap(
                            initialCameraPosition: CameraPosition(target: value, zoom: 33),
                            gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                              Factory<OneSequenceGestureRecognizer>(
                                () => EagerGestureRecognizer(),
                              ),
                            },
                            onTap: (latLng) => selectedLocation.value = latLng,
                            markers: {
                              Marker(
                                markerId: const MarkerId('1'),
                                position: value,
                              ),
                            },
                            onCameraMove: (position) => selectedLocation.value = position.target,
                          ),
                        );
                      },
                    ),
                  ),
                  AppTextField.withLabel(
                    label: LocaleKeys.address_name.tr(),
                    controller: _titleController,
                    hintText: LocaleKeys.address_name_hint.tr(),
                    validator: (value) => ValidationHelper.validateRequiredField(value!, LocaleKeys.address_name.tr()),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) return;
                      AppNavigator.pop(Address(
                        id: widget.address?.id ?? 0,
                        title: _titleController.text,
                        latitude: selectedLocation.value!.latitude,
                        longitude: selectedLocation.value!.longitude,
                      ));
                    },
                    child: Text(widget.address == null ? LocaleKeys.add.tr() : LocaleKeys.update.tr()),
                  ),
                ],
              ).withSpacing(spacing: 16.h),
            ),
          );
        },
      ),
    );
  }
}
