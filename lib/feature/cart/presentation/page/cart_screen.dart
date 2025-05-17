import 'package:bookia/core/extentions/extentions.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/core/widgets/custom_button.dart';
import 'package:bookia/core/widgets/dialogs.dart';
import 'package:bookia/feature/cart/presentation/cubit/cart_cubit.dart';
import 'package:bookia/feature/cart/presentation/page/success.dart';
import 'package:bookia/feature/cart/presentation/widgets/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit()..getCart(),
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Cart', style: getTitleTextStyle(context))),
        ),
        body: BlocConsumer<CartCubit, CartState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is CartSuccessState) {
              var books =
                  context.read<CartCubit>().cartResponse?.data?.cartItems ?? [];
              var total =
                  context.read<CartCubit>().cartResponse?.data?.total ?? 0;
              return books.isEmpty
                  ? Center(child: Text('Your cart is empty'))
                  : Padding(
                    padding: const EdgeInsets.all(22),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                            separatorBuilder:
                                (context, index) => const Divider(height: 40),
                            itemCount: books.length,
                            itemBuilder: (BuildContext context, int index) {
                              return CartItemWidget(
                                books: books[index],
                                onDelete: () {
                                  context.read<CartCubit>().removeFromCart(
                                    books[index].itemId ?? 0,
                                  );
                                },
                                onAdd: () {
                                  if ((books[index].itemQuantity ?? 0) <
                                      (books[index].itemProductStock ?? 0)) {
                                    context.read<CartCubit>().updateCart(
                                      books[index].itemId ?? 0,
                                      (books[index].itemQuantity ?? 0) + 1,
                                    );
                                  } else {
                                    showToast(
                                      context,
                                      "Can't add more (Quantity out of stock)",
                                    );
                                  }
                                },
                                onRemove: () {
                                  if ((books[index].itemQuantity ?? 0) > 1) {
                                    context.read<CartCubit>().updateCart(
                                      books[index].itemId ?? 0,
                                      (books[index].itemQuantity ?? 0) - 1,
                                    );
                                  } else {
                                    showToast(context, "Can't remove more");
                                  }
                                },
                              );
                            },
                          ),
                        ),
                        Column(
                          children: [
                            Divider(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total:',
                                  style: getBodyTextStyle(context),
                                ),
                                Text(
                                  '\$$total',
                                  style: getBodyTextStyle(context),
                                ),
                              ],
                            ),
                            Gap(25),
                            CustomButton(
                              text: 'Checkout',
                              onPressed: () async {
                                await context.read<CartCubit>().clearCart();
                                context.pushReplacement(SuccessScreen());
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
