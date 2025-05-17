import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/feature/home/presentation/cubit/home_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeSliderWidget extends StatefulWidget {
  const HomeSliderWidget({super.key});

  @override
  State<HomeSliderWidget> createState() => _HomeSliderWidgetState();
}

class _HomeSliderWidgetState extends State<HomeSliderWidget> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen:
          (previous, current) =>
              current is SliderLoadedState ||
              current is SliderLoadingState ||
              current is SliderErrorState,
      builder: (context, state) {
        if (state is SliderLoadedState) {
          var sliders =
              context.read<HomeCubit>().sliderResponse?.data?.sliders ?? [];
          return Column(
            children: [
              CarouselSlider.builder(
                itemCount: sliders.length,
                itemBuilder: (
                  BuildContext context,
                  int itemIndex,
                  int pageViewIndex,
                ) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: sliders[itemIndex].image ?? '',
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  );
                },
                options: CarouselOptions(
                  height: 150,
                  viewportFraction: 0.9,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.3,
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  scrollDirection: Axis.horizontal,
                ),
              ),
              Gap(10),
              SmoothPageIndicator(
                controller: PageController(initialPage: currentIndex),
                count: sliders.length,
                effect: ExpandingDotsEffect(
                  dotColor: AppColors.greyColor,
                  dotHeight: 7,
                  dotWidth: 7,
                  expansionFactor: 4,
                  spacing: 5,
                  activeDotColor: AppColors.primaryColor,
                ),
                onDotClicked: (index) {},
              ),
            ],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
