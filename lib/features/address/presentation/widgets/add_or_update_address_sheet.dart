part of '../presentation_imports.dart';

class AddAddressSheet extends StatefulWidget {
  const AddAddressSheet({super.key}) : address = null;

  const AddAddressSheet.update({super.key, required this.address});

  final Address? address;

  @override
  State<AddAddressSheet> createState() => _AddAddressSheetState();
}

class _AddAddressSheetState extends State<AddAddressSheet> {
  final _formKey = GlobalKey<FormState>();
  ValueNotifier<LatLng> selectedLocation = ValueNotifier(const LatLng(0, 0));
  final _titleController = TextEditingController();

  GoogleMapController? mapController;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.address != null) {
        selectedLocation = ValueNotifier(LatLng(widget.address!.latitude, widget.address!.longitude));
        mapController?.animateCamera(CameraUpdate.newLatLng(LatLng(widget.address!.latitude, widget.address!.longitude)));
        _titleController.text = widget.address!.title;
      } else {
        getInitialPosition();
      }
    });
    super.initState();
  }

  void getInitialPosition() async {
    final position = await LocationHelper.getCurrentPosition();
    if (position == null) return;
    selectedLocation.value = LatLng(position.latitude, position.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.all(16.0).copyWith(
        bottom: context.bottomBarHeight + 16.h,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 200.h,
              child: ValueListenableBuilder(
                valueListenable: selectedLocation,
                builder: (context, LatLng value, child) {
                  return GoogleMap(
                    initialCameraPosition: CameraPosition(target: value, zoom: 33),
                    gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                      Factory<OneSequenceGestureRecognizer>(() => EagerGestureRecognizer()),
                    },
                    onMapCreated: (controller) => mapController = controller,
                    onTap: (latLng) => selectedLocation.value = latLng,
                    markers: {
                      Marker(
                        markerId: const MarkerId('1'),
                        position: value,
                      ),
                    },
                    onCameraMove: (position) => selectedLocation.value = position.target,
                  ).asFormField(validator: (_) => ValidationHelper.validateValue<LatLng>(selectedLocation.value, 'الموقع'));
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
                AppNavigator.pop<Address>(
                  Address(
                    id: widget.address?.id ?? 0,
                    title: _titleController.text,
                    latitude: selectedLocation.value.latitude,
                    longitude: selectedLocation.value.longitude,
                  ),
                );
              },
              child: Text(widget.address == null ? 'Add' : 'Update'),
            ),
          ],
        ).withSpacing(spacing: 16.h),
      ),
    );
  }
}
