import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/core/theme/app_colors.dart';


class AppTextFormField extends StatelessWidget {
  const AppTextFormField(
      {super.key,
      this.keyboardType,
      this.contentPadding,
      this.focusedBorder,
      this.border,
      this.hintStyle,
      this.inputStyle,
      required this.hintText,
      this.obscureText,
      this.suffixIcon,
      this.bgColor,
      required this.controller,
      required this.validator,
      this.label});
  final TextInputType? keyboardType;
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? focusedBorder;
  final InputBorder? border;
  final TextStyle? hintStyle;
  final TextStyle? inputStyle;
  final String? hintText;
  final bool? obscureText;
  final Color? bgColor;
  final Widget? suffixIcon;
  final TextEditingController controller;
  final Function(String?) validator;
  final Widget? label;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType ?? TextInputType.text,
      controller: controller,
      // validator: validator,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: contentPadding ??
            EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: Color.fromARGB(0, 49, 49, 49),
              width: 1.3,
            )),

        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: AppColors.scaffoldDark,
              width: 1.3,
            )),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.3,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1.3,
            )),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),

        // labelStyle: MyTextStyle.font14lightGrayRegular ,
        hintStyle: hintStyle ?? Theme.of(context).textTheme.labelLarge,
        hintText: hintText,
        suffixIcon: suffixIcon,
        fillColor: bgColor ?? AppColors.lightGray,
        filled: true,
        label: label,
      ),
      obscureText: obscureText ?? false,
      style: inputStyle ??Theme.of(context).textTheme.labelLarge,
      validator: ((value) => validator(value)),
    );
  }
}
