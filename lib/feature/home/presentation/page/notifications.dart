import 'package:bookia/core/constants/assets_manager.dart';
import 'package:bookia/core/extentions/extentions.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/feature/home/presentation/page/search_screen.dart';
import 'package:bookia/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            context.pushAndRemoveUntil(MainAppScreen());
          },
          child: SvgPicture.asset(AssetsManager.logoSvg, height: 30),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              AssetsManager.notification,
              color: AppColors.primaryColor,
              height: 25,
            ),
          ),
          IconButton(
            onPressed: () {
              context.pushTo(SearchScreen());
            },
            icon: SvgPicture.asset(AssetsManager.search, height: 25),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            LottieBuilder.asset("assets/images/no_notifications.json"),
            Text(
              "You don't have any notifictaions yet.",
              style: getBodyTextStyle(context),
            ),
            Spacer(),
            Spacer(),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
