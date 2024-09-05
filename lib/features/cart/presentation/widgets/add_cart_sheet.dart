part of '../presentation_imports.dart';

class AddToCartSheet extends StatefulWidget {
  const AddToCartSheet({super.key, required this.cartCubit});

  final CartCubit cartCubit;

  @override
  State<AddToCartSheet> createState() => _AddToCartSheetState();
}

class _AddToCartSheetState extends State<AddToCartSheet> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.cartCubit,
      child: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {
          if (state.addToCartStatus == UsecaseStatus.completed) {
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
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(labelText: 'Title'),
                  ),
                  TextField(
                    controller: _bodyController,
                    decoration: const InputDecoration(labelText: 'Body'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) return;
                      if (state.addToCartStatus == UsecaseStatus.running) return;

                      // widget.cartCubit.addToCart(AddCartParams());
                    },
                    child: state.addToCartStatus == UsecaseStatus.running ? const CircularProgressIndicator.adaptive() : const Text('Add'),
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
