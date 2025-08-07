import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app1/auth/login/cubit/login_cubit.dart';

class NotesHeader extends StatelessWidget {
  final String? username;
  final String date;
  final VoidCallback? onMorePressed;

  const NotesHeader({
    super.key,
    this.username,
    this.date = '22 December, 2021',
    this.onMorePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: ${username ?? "Guest"} ',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              date,
              style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600),
            ),
            SizedBox(height: 4.h),
            Text(
              'Notes',
              style: TextStyle(
                fontSize: 26.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) {
            return IconButton.outlined(
              onPressed:
                  onMorePressed ??
                  () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        title: Row(
                          children: [
                            Icon(Icons.logout, color: Colors.blue),
                            SizedBox(width: 8.w),
                            Text(
                              'Logout',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.sp,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                        content: Text(
                          'Are you sure you want to log out?',

                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black87,
                          ),
                        ),
                        actionsPadding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 8.h,
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              'Cancel',
                              style: TextStyle(color: Colors.grey.shade700),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context); // Close dialog
                              context.read<LoginCubit>().logout(
                                context,
                              ); // Logout
                            },
                            child: const Text(
                              'Log out',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    );
                  },

              style: OutlinedButton.styleFrom(
                minimumSize: Size(22.w, 22.h),
                side: const BorderSide(color: Colors.blue),
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              icon: Padding(
                padding: EdgeInsets.all(4.0.r),
                child: Icon(Icons.more_horiz, size: 16.sp, color: Colors.blue),
              ),
            );
          },
        ),
      ],
    );
  }
}
