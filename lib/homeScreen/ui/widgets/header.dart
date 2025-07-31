import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotesHeader extends StatelessWidget {
  final String title;
  final String date;
  final VoidCallback? onMorePressed;

  const NotesHeader({
    super.key,
    this.title = 'Notes',
    this.date = '22 December, 2021',
    this.onMorePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
          IconButton.outlined(
            onPressed: onMorePressed ?? () {},
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
          ),
        ],
      ),
    );
  }
}
