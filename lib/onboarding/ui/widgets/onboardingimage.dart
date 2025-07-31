import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Onboardingimage extends StatelessWidget {
  const Onboardingimage({super.key, required this.imagePath});
  final String imagePath;
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Image.asset(imagePath, width: 223.w, height: 304.h),
    );
  }
}
