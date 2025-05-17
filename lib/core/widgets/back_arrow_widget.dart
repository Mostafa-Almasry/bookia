import 'package:bookia/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class BackArrowWidget extends StatelessWidget {
  const BackArrowWidget({super.key, this.onTap});
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => Navigator.pop(context),
      child: Container(
        width: 40,
        height: 40,
        padding: const EdgeInsets.only(left: 6),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.borderColor, width: 1),
          borderRadius: BorderRadius.circular(12),
          color: AppColors.whiteColor,
        ),
        child: const Icon(
          Icons.arrow_back_ios,
          color: AppColors.blackColor,
          size: 20,
        ),
      ),
    );
  }
}
