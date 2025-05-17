import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/core/widgets/custom_button.dart';
import 'package:bookia/feature/home/data/models/product.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class WishlistItem extends StatelessWidget {
  const WishlistItem({
    super.key,
    required this.books,
    required this.onRemove,
    required this.onAddToCart,
  });

  final Product books;
  final Function() onRemove;
  final Function() onAddToCart;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(
            imageUrl: books.image ?? '',
            width: 100,
            height: 120,
            fit: BoxFit.cover,
          ),
        ),
        const Gap(10),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      books.name ?? '',
                      style: getBodyTextStyle(context),
                    ),
                  ),
                  CloseButton(onPressed: onRemove),
                ],
              ),
              Text(
                "\$${books.price ?? ''}",
                style: getBodyTextStyle(context, fontSize: 16),
              ),
              const Gap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomButton(
                    text: 'Add To Cart',
                    onPressed: onAddToCart,
                    width: 170,
                    height: 40,
                    bgColor: AppColors.primaryColor,
                    radius: 4,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
