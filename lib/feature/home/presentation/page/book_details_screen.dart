import 'package:bookia/core/constants/assets_manager.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/core/widgets/back_arrow_widget.dart';
import 'package:bookia/core/widgets/custom_button.dart';
import 'package:bookia/core/widgets/dialogs.dart';
import 'package:bookia/feature/home/data/models/product.dart';
import 'package:bookia/feature/home/presentation/cubit/home_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class BookDetailsScreen extends StatelessWidget {
  const BookDetailsScreen({super.key, required this.book});
  final Product book;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is AddToWishlistCartSuccessState) {
            Navigator.pop(context);
            showToast(context, state.message, type: ToastType.success);
          } else if (state is AddToWishlistCartErrorState) {
            Navigator.pop(context);
            showToast(context, 'Added to wishlist', type: ToastType.error);
          } else if (state is AddToWishlistCartLoadingState) {
            showLoadingDialog(context);
          }
        },
        builder:
            (context, state) => Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: BackArrowWidget(),
                actions: [
                  IconButton(
                    onPressed: () {
                      context.read<HomeCubit>().addToWishlist(book.id ?? 0);
                    },
                    icon: SvgPicture.asset(AssetsManager.bookmark),
                  ),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Hero(
                              tag: book.id ?? '',
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(7),
                                child: CachedNetworkImage(
                                  imageUrl: book.image ?? '',
                                  height: 270,
                                ),
                              ),
                            ),
                            Gap(15),
                            Text(
                              book.name ?? '',
                              textAlign: TextAlign.center,
                              style: getTitleTextStyle(context),
                            ),
                            const Gap(10),
                            Text(
                              book.category ?? '',
                              style: getBodyTextStyle(
                                context,
                                color: AppColors.primaryColor,
                              ),
                            ),
                            const Gap(20),
                            Text(
                              book.description ?? '',
                              textAlign: TextAlign.justify,
                              style: getSmallTextStyle(
                                color: AppColors.darkColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "\$${book.priceAfterDiscount}",
                            style: getTitleTextStyle(context),
                          ),
                          CustomButton(
                            text: 'Add To Cart',
                            onPressed: () {
                              context.read<HomeCubit>().addToCart(book.id ?? 0);
                            },
                            width: 200,
                            bgColor: AppColors.darkColor,
                            radius: 8,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
      ),
    );
  }
}
