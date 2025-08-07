import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app1/homeScreen/bloC/cubit/home_screen_cubit.dart';

class EditScreen extends StatefulWidget {
  final String noteId;

  const EditScreen({super.key, required this.noteId});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  late final TextEditingController titleController;
  late final TextEditingController contentController;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<HomeScreenCubit>();
    titleController = TextEditingController(text: cubit.titleController.text);
    contentController = TextEditingController(
      text: cubit.contentController.text,
    );
  }

  Future<void> _saveEditedNote() async {
    if (!(formKey.currentState?.validate() ?? false)) return;

    setState(() => isLoading = true);
    final cubit = context.read<HomeScreenCubit>();

    try {
      await cubit.editNote(
        widget.noteId,
        titleController.text,
        contentController.text,
      );

      if (mounted) {
        Navigator.pop(context, true); // return to previous screen
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 12.w),
                const Expanded(
                  child: Text(
                    'Note edited successfully',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.edit_off_outlined, color: Colors.white),
                SizedBox(width: 12.w),
                const Expanded(
                  child: Text(
                    'Edit failed',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.redAccent,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Scaffold(
        appBar: AppBar(title: const Text('Edit Note')),
        body: Padding(
          padding: EdgeInsets.all(24.0.r),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Enter a title' : null,
                ),
                SizedBox(height: 16.h),
                TextFormField(
                  controller: contentController,
                  decoration: const InputDecoration(
                    labelText: 'Content',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 6,
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Enter content' : null,
                ),
                SizedBox(height: 24.h),
                isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton.icon(
                        onPressed: _saveEditedNote,
                        icon: const Icon(Icons.save),
                        label: const Text('Save Changes'),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
