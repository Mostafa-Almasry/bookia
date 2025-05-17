part of 'cart_cubit.dart';

sealed class CartState {}

final class CartInitial extends CartState {}

final class CartLoadingState extends CartState {}

final class CartSuccessState extends CartState {}

final class CartErrorState extends CartState {
  final String message;
  CartErrorState(this.message);
}
