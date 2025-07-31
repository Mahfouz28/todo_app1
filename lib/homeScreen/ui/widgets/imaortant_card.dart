import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImportantInfo extends StatelessWidget {
  final String title;
  final String subtitle;
  final String prefixText;
  final String boldText;

  const ImportantInfo({
    super.key,
    required this.title,
    required this.subtitle,
    required this.prefixText,
    required this.boldText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 15.r, bottom: 15.r, right: 6.r, left: 15.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
          ),
          SizedBox(height: 8.h),
          Text(subtitle),
          SizedBox(height: 4.h),
          Text.rich(
            TextSpan(
              text: prefixText,
              children: [
                TextSpan(
                  text: boldText,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
