import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/feature/home/presentation/cubit/home_cubit.dart';
import 'package:bookia/feature/home/presentation/widgets/book_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class BestSellersWidget extends StatelessWidget {
  const BestSellersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen:
          (previous, current) =>
              current is BestSellerLoadedState ||
              current is BestSellerLoadingState ||
              current is BestSellerErrorState,
      builder: (context, state) {
        if (state is BestSellerLoadedState) {
          var books =
              context.read<HomeCubit>().bestSellerResponse?.data?.products ??
              [];
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Best Sellers', style: getTitleTextStyle(context)),
                const Gap(10),
                GridView.builder(
                  shrinkWrap: true, // Don't expand infinitely
                  physics:
                      const NeverScrollableScrollPhysics(), // Don't scroll yourself let the column scroll (single child scroll view)
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    mainAxisExtent: 270,
                  ),
                  itemCount: books.length,
                  itemBuilder: (BuildContext context, int index) {
                    return BookItem(book: books[index]);
                  },
                ),
              ],
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
