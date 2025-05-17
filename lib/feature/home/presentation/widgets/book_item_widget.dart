import 'package:bookia/core/extentions/extentions.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/core/widgets/custom_button.dart';
import 'package:bookia/core/widgets/dialogs.dart';
import 'package:bookia/feature/home/data/models/product.dart';
import 'package:bookia/feature/home/presentation/cubit/home_cubit.dart';
import 'package:bookia/feature/home/presentation/page/book_details_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class BookItem extends StatelessWidget {
  const BookItem({super.key, required this.book});
  final Product book;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushTo(BookDetailsScreen(book: book));
      },
      child: Hero(
        tag: book.id?? '',
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.scondaryColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: book.image ?? '',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    errorWidget: (context, url, error) {
                      return const Center(child: Icon(Icons.error));
                    },
                  ),
                ),
              ),
              Gap(10),
              Text(
                book.name ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: getBodyTextStyle(context),
              ),
              Gap(5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\$${book.priceAfterDiscount}",
                    style: getBodyTextStyle(context, fontSize: 16),
                  ),
                  CustomButton(
                    text: 'Buy',
                    onPressed: () {
                      context.read<HomeCubit>().addToCart(book.id!);
                      showToast(
                        context,
                        type: ToastType.success,
                        'Added to Cart',
                      );
                    },
                    width: 80,
                    height: 30,
                    bgColor: AppColors.darkColor,
                    radius: 4,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
