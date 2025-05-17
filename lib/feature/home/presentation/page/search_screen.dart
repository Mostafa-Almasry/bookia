import 'package:bookia/core/constants/assets_manager.dart';
import 'package:bookia/core/extentions/extentions.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/core/widgets/custom_button.dart';
import 'package:bookia/core/widgets/custom_text_form_field.dart';
import 'package:bookia/core/widgets/dialogs.dart';
import 'package:bookia/feature/home/data/models/product.dart';
import 'package:bookia/feature/home/presentation/cubit/home_cubit.dart';
import 'package:bookia/feature/home/presentation/page/book_details_screen.dart';
import 'package:bookia/feature/home/presentation/page/notifications.dart';
import 'package:bookia/main/main_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  HomeCubit? _homeCubit;
  final List<int> categories = [2, 3, 4];
  final List<String> categoriesName = [
    'Software',
    'DevOps',
    'AI & Data Science',
  ];

  @override
  void initState() {
    super.initState();
    _homeCubit = HomeCubit(); // Initialize the cubit
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = _searchController.text.trim();

    if (query.isNotEmpty) {
      _homeCubit!.searchProducts(query);
    } else {
      _homeCubit!.clearSearchResults();
    }
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _homeCubit?.close(); // Safe close with null check
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _homeCubit!, // We know it's initialized by now
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is SearchLoadedStateWithMessage) {
            showToast(context, state.message, type: ToastType.success);
          }
        },
        builder:
            (context, state) => Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
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
                    icon: SvgPicture.asset(
                      AssetsManager.notification,
                      height: 25,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      AssetsManager.search,
                      color: AppColors.primaryColor,
                      height: 25,
                    ),
                  ),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: [
                    CustomTextFormField(
                      controller: _searchController,
                      hintText: 'Search Books...s',
                      autoFocus: true,
                    ),
                    Gap(18),
                    SizedBox(
                      height: 45,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        separatorBuilder: (context, index) => Gap(5),
                        itemBuilder: (context, index) {
                          return ElevatedButton(
                            onPressed:
                                () =>
                                    _homeCubit!.showCategory(categories[index]),
                            style: ElevatedButton.styleFrom(
                              elevation: 1,
                              backgroundColor: AppColors.primaryColor,
                              foregroundColor: AppColors.blackColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                                side: BorderSide(color: AppColors.primaryColor),
                              ),
                            ),
                            child: Text(categoriesName[index]),
                          );
                        },
                      ),
                    ),
                    Gap(25),

                    Expanded(
                      child: BlocBuilder<HomeCubit, HomeState>(
                        buildWhen:
                            (previous, current) =>
                                state is SearchLoadingState ||
                                state is SearchLoadedState ||
                                state is SearchErrorState,
                        builder: (context, state) {
                          if (state is SearchLoadingState) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is SearchLoadedState) {
                            final results = state.results;
                            return ListView.separated(
                              physics: const ClampingScrollPhysics(),
                              keyboardDismissBehavior:
                                  ScrollViewKeyboardDismissBehavior.onDrag,
                              separatorBuilder:
                                  (context, index) => const Divider(height: 40),
                              itemCount: results.length,
                              itemBuilder: (BuildContext context, int index) {
                                final product = results[index];
                                return ResultWidget(product: product);
                              },
                            );
                          } else if (state is SearchErrorState) {
                            return Center(child: Text(state.message));
                          } else {
                            return const SizedBox(height: 10);
                          }
                        },
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

class ResultWidget extends StatelessWidget {
  const ResultWidget({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushTo(BookDetailsScreen(book: product));
      },
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: product.image ?? '',
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
                        product.name ?? '',
                        style: getBodyTextStyle(context),
                      ),
                    ),
                  ],
                ),
                Text(
                  "\$${product.price ?? ''}",
                  style: getBodyTextStyle(context, fontSize: 16),
                ),
                const Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButton(
                      text: 'Add To Cart',
                      onPressed: () async {
                        await context.read<HomeCubit>().addToCart(
                          product.id ?? 0,
                        );
                      },
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
      ),
    );
  }
}
