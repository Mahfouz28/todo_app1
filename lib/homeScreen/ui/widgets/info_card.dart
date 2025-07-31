import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final String description;
  final String boldText;
  final String footer;

  const InfoCard({
    super.key,
    required this.title,
    required this.description,
    required this.boldText,
    required this.footer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160.w,
      height: 198.h,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(color: Colors.black12, offset: const Offset(0, 0)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.h),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: description,
                  style: TextStyle(fontSize: 12.sp, color: Colors.black87),
                ),
                TextSpan(
                  text: boldText,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.sp,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),

          Text(
            footer,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
