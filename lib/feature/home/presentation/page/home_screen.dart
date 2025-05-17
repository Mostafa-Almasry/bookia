import 'package:bookia/core/constants/assets_manager.dart';
import 'package:bookia/core/extentions/extentions.dart';
import 'package:bookia/feature/home/presentation/cubit/home_cubit.dart';
import 'package:bookia/feature/home/presentation/page/notifications.dart';
import 'package:bookia/feature/home/presentation/page/search_screen.dart';
import 'package:bookia/feature/home/presentation/widgets/all_products_widget.dart';
import 'package:bookia/feature/home/presentation/widgets/best_sellers_widget.dart';
import 'package:bookia/feature/home/presentation/widgets/home_slider_widget.dart';
import 'package:bookia/feature/home/presentation/widgets/new_arrivals_widget.dart';
import 'package:bookia/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              HomeCubit()
                ..getBestSeller()
                ..getSliders()
                ..getAllProducts()
                ..getNewArrivals(),
      child: Scaffold(
        appBar: AppBar(
          title: GestureDetector(
            onTap: () {
              context.pushAndRemoveUntil(MainAppScreen());
            },
            child: SvgPicture.asset(AssetsManager.logoSvg, height: 30),
          ),
          actions: [
            IconButton(
              onPressed: () {
                context.pushAndRemoveUntil(NotificationsScreen());
              },
              icon: SvgPicture.asset(AssetsManager.notification, height: 25),
            ),
            IconButton(
              onPressed: () {
                context.pushTo(SearchScreen());
              },
              icon: SvgPicture.asset(AssetsManager.search, height: 25),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Gap(5),
              HomeSliderWidget(),
              NewArrivalsWidget(),
              const Gap(10),
              BestSellersWidget(),
              const Gap(10),
              AllProductsWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
