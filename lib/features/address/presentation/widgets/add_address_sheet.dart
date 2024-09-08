part of '../presentation_imports.dart';

class AddAddressSheet extends StatefulWidget {
  const AddAddressSheet({super.key, required this.addressCubit});

  final AddressCubit addressCubit;

  @override
  State<AddAddressSheet> createState() => _AddAddressSheetState();
}

class _AddAddressSheetState extends State<AddAddressSheet> {
  final _formKey = GlobalKey<FormState>();
  ValueNotifier<LatLng?> selectedLocation = ValueNotifier(null);
  final _titleController = TextEditingController();

  @override
  void initState() {
    getInitialPosition();
    super.initState();
  }

  void getInitialPosition() async {
    final position = await LocationHelper.getCurrentPosition();
    selectedLocation.value = LatLng(position.latitude, position.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.addressCubit,
      child: BlocConsumer<AddressCubit, AddressState>(
        listener: (context, state) {
          if (state.addAddressestatus == UsecaseStatus.completed) {
            AppNavigator.pop();
          }
        },
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
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: 'اسم العنوان',
                    ),
                    validator: (value) => ValidationHelper.validateRequiredField(value!, 'اسم العنوان'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) return;
                      if (state.addAddressestatus == UsecaseStatus.running) return;

                      widget.addressCubit.addAddress(AddAddressParams(
                        title: _titleController.text,
                        latitude: selectedLocation.value!.latitude,
                        longitude: selectedLocation.value!.longitude,
                      ));
                    },
                    child: state.addAddressestatus == UsecaseStatus.running ? const CircularProgressIndicator.adaptive() : const Text('Add'),
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
