part of 'wishlist_cubit.dart';

sealed class WishlistState {}

final class WishlistInitial extends WishlistState {}

final class WishlistLoadingState extends WishlistState {}

final class WishlistSuccessState extends WishlistState {}

final class WishlistErrorState extends WishlistState {
  final String message;
  WishlistErrorState(this.message);
}

final class AddToCartLoadingState extends WishlistState {}

final class AddToCartSuccessState extends WishlistState {}

final class AddToCartErrorState extends WishlistState {
  final String message;
  AddToCartErrorState(this.message);
}
