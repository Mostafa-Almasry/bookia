import 'package:bookia/core/constants/assets_manager.dart';
import 'package:bookia/core/extentions/extentions.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/core/widgets/custom_button.dart';
import 'package:bookia/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AssetsManager.success, width: 100, height: 100),
            Gap(35),

            Text('SUCCESS!', style: getHeadlineTextStyle(context)),
            Gap(3),

            Text(
              "Your order will be delivered soon. Thank you for choosing our app!",
              style: getBodyTextStyle(
                context,
                color: AppColors.greyColor,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            Gap(40),
            CustomButton(
              text: 'Back To Home',
              onPressed: () {
                context.pushReplacement(MainAppScreen());
              },
            ),
          ],
        ),
      ),
    );
  }
}
