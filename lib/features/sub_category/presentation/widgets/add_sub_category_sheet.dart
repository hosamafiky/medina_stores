part of '../presentation_imports.dart';

class AddSubCategorySheet extends StatefulWidget {
  const AddSubCategorySheet({super.key, required this.subCategoryCubit});

  final SubCategoryCubit subCategoryCubit;

  @override
  State<AddSubCategorySheet> createState() => _AddSubCategorySheetState();
}

class _AddSubCategorySheetState extends State<AddSubCategorySheet> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.subCategoryCubit,
      child: BlocConsumer<SubCategoryCubit, SubCategoryState>(
        listener: (context, state) {
          if (state.addSubCategoryStatus == UsecaseStatus.completed) {
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
                      if (state.addSubCategoryStatus == UsecaseStatus.running) return;

                      widget.subCategoryCubit.addSubCategory(AddSubCategoryParams());
                    },
                    child: state.addSubCategoryStatus == UsecaseStatus.running ? const CircularProgressIndicator.adaptive() : const Text('Add'),
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
