import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/core/widgets/dialogs.dart';
import 'package:bookia/feature/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:bookia/feature/wishlist/presentation/widgets/wishlist_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WishlistCubit()..getWishlist(),
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text('Wishlist', style: getTitleTextStyle(context)),
          ),
        ),
        body: BlocConsumer<WishlistCubit, WishlistState>(
          buildWhen:
              (previous, current) =>
                  current is WishlistSuccessState ||
                  current is WishlistLoadingState ||
                  current is WishlistErrorState,
          listener: (context, state) {
            if (state is AddToCartSuccessState) {
              Navigator.pop(context);
              showToast(context, 'Added To Cart', type: ToastType.success);
            } else if (state is AddToCartErrorState) {
              Navigator.pop(context);
              showToast(context, 'Error Adding to Cart', type: ToastType.error);
            } else if (state is AddToCartLoadingState) {
              showLoadingDialog(context);
            }
          },
          builder: (context, state) {
            if (state is WishlistSuccessState) {
              var books =
                  context.read<WishlistCubit>().wishlistResponse?.data?.data ??
                  [];
              return books.isEmpty
                  ? Center(child: Text('Your Wishlist is empty'))
                  : ListView.separated(
                    padding: EdgeInsets.all(20),
                    separatorBuilder:
                        (context, index) => const Divider(height: 40),
                    itemCount: books.length,
                    itemBuilder: (BuildContext context, int index) {
                      return WishlistItem(
                        books: books[index],
                        onRemove: () {
                          context.read<WishlistCubit>().removeFromWishlist(
                            books[index].id ?? 0,
                          );
                        },
                        onAddToCart: () {
                          context.read<WishlistCubit>().addToCart(
                            books[index].id ?? 0,
                          );
                        },
                      );
                    },
                  );
            } else {
              return Center(child: const CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
