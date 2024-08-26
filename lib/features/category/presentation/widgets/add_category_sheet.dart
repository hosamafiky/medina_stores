part of '../presentation_imports.dart';

class AddCategorySheet extends StatefulWidget {
  const AddCategorySheet({super.key, required this.categoryCubit});

  final CategoryCubit categoryCubit;

  @override
  State<AddCategorySheet> createState() => _AddCategorySheetState();
}

class _AddCategorySheetState extends State<AddCategorySheet> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.categoryCubit,
      child: BlocConsumer<CategoryCubit, CategoryState>(
        listener: (context, state) {
          if (state.addCategoryStatus == UsecaseStatus.completed) {
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
                      if (state.addCategoryStatus == UsecaseStatus.running) return;

                      widget.categoryCubit.addCategory(AddCategoryParams());
                    },
                    child: state.addCategoryStatus == UsecaseStatus.running ? const CircularProgressIndicator.adaptive() : const Text('Add'),
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
