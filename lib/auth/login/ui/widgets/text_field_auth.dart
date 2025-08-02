import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFieldAuth extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final IconData? prefixIcon;
  final bool obscureText;
  final FormFieldValidator<String>? validator;
  final TextInputType keyboardType;
  final IconData? suffixIcon;
  final String fieldName;

  const TextFieldAuth({
    super.key,
    this.controller,
    required this.hintText,
    this.prefixIcon,
    this.obscureText = false,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
    required this.fieldName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 35.0.r),
      child: SizedBox(
        height: 102.h, // Increased height to fit error text
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              fieldName,
              style: TextStyle(fontSize: 10.r, color: Colors.grey),
            ),
            SizedBox(height: 4.h),
            TextFormField(
              controller: controller,
              obscureText: obscureText,
              validator: validator,
              keyboardType: keyboardType,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 18.h,
                ),
                hintText: hintText,
                hintStyle: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.blueGrey[300],
                ),
                filled: true,
                fillColor: Colors.grey[300],
                suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
                suffixIconColor: Colors.grey,
                prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                // Add error borders:
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1.5),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 2),
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
