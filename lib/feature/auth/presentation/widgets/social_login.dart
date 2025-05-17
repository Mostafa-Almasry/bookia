import 'package:bookia/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SocialLogin extends StatelessWidget {
  const SocialLogin({super.key, required this.asset});
  final String asset;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.borderColor, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: SvgPicture.asset(asset),
      ),
    );
  }
}
