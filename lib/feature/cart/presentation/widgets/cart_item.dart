import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/feature/Cart/data/models/get_Cart_response/cart_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({
    super.key,
    required this.books,
    required this.onDelete,
    required this.onAdd,
    required this.onRemove,
  });

  final CartItem books;
  final Function() onDelete;
  final Function() onAdd;
  final Function() onRemove;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(
            imageUrl: books.itemProductImage ?? '',
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
                      books.itemProductName ?? '',
                      style: getBodyTextStyle(context),
                    ),
                  ),
                  CloseButton(onPressed: onDelete),
                ],
              ),
              Text(
                "\$${(books.itemProductPriceAfterDiscount ?? '')}",
                style: getBodyTextStyle(context, fontSize: 16),
              ),
              const Gap(10),
              Row(
                children: [
                  FloatingActionButton.small(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    backgroundColor: AppColors.accentColor,
                    onPressed: onAdd,
                    child: Icon(Icons.add),
                  ),
                  const Gap(10),
                  Text(
                    books.itemQuantity.toString(),
                    style: getBodyTextStyle(context),
                  ),
                  const Gap(10),
                  FloatingActionButton.small(
                    elevation: 0,
                    backgroundColor: AppColors.accentColor,
                    onPressed: onRemove,
                    child: Icon(Icons.remove),
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
