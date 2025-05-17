part of 'home_cubit.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

// Slider, Best Sellers, New Arrivals and All Products States
final class SliderLoadingState extends HomeState {}

final class SliderLoadedState extends HomeState {}

final class SliderErrorState extends HomeState {
  final String message;
  SliderErrorState(this.message);
}

final class BestSellerLoadingState extends HomeState {}

final class BestSellerLoadedState extends HomeState {}

final class BestSellerErrorState extends HomeState {
  final String message;
  BestSellerErrorState(this.message);
}

final class NewArrivalsLoadingState extends HomeState {}

final class NewArrivalsLoadedState extends HomeState {}

final class NewArrivalsErrorState extends HomeState {
  final String message;
  NewArrivalsErrorState(this.message);
}

final class AllProductsLoadingState extends HomeState {}

final class AllProductsLoadedState extends HomeState {}

final class AllProductsErrorState extends HomeState {
  final String message;
  AllProductsErrorState(this.message);
}

// Add to Wishlist and Cart States
final class AddToWishlistCartLoadingState extends HomeState {}

final class AddToWishlistCartSuccessState extends HomeState {
  final String message;
  AddToWishlistCartSuccessState(this.message);
}

final class AddToWishlistCartErrorState extends HomeState {
  final String message;
  AddToWishlistCartErrorState(this.message);
}

final class SearchLoadingState extends HomeState {}

final class SearchLoadedState extends HomeState {
  final List<Product> results;
  SearchLoadedState(this.results);
}

final class SearchErrorState extends HomeState {
  final String message;
  SearchErrorState(this.message);
}

final class SearchLoadedStateWithMessage extends SearchLoadedState {
  final String message;
  SearchLoadedStateWithMessage(super.results, this.message);
}
