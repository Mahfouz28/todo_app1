import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImportantInfo extends StatelessWidget {
  final String title;
  final String subtitle;
  final String prefixText;
  final String boldText;
  final VoidCallback onPressed;

  const ImportantInfo({
    super.key,
    required this.title,
    required this.subtitle,
    required this.prefixText,
    required this.boldText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: 10.r, bottom: 15.r, right: 6.r, left: 15.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
              ),
              TextButton(
                onPressed: onPressed,
                child: Text("Edit", style: TextStyle(color: Colors.blue)),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            subtitle,
            style: TextStyle(color: Colors.black87, fontSize: 14.sp),
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
          ),

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
