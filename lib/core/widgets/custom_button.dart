import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    this.width,
    this.height,
    required this.onPressed,
    this.hasBorder = false,
    this.bgColor = AppColors.primaryColor,
    this.fgColor = AppColors.whiteColor,
    this.radius,
    this.fontSize,
  });

  final String text;
  final Function() onPressed;
  final double? width;
  final double? height;
  final bool hasBorder;
  final Color bgColor;
  final Color fgColor;
  final double? radius;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 55,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 10),
          ),
          side:
              hasBorder
                  ? const BorderSide(color: AppColors.darkColor, width: 1)
                  : null,
          backgroundColor: bgColor,
        ),
        child: Text(
          text,
          style: getBodyTextStyle(context, color: fgColor, fontSize: fontSize),
        ),
      ),
    );
  }
}
