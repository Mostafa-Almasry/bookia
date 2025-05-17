import 'package:bloc/bloc.dart';
import 'package:bookia/feature/Cart/data/models/get_Cart_response/get_Cart_response.dart';
import 'package:bookia/feature/cart/data/repo/cart_repo.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  GetCartResponse? cartResponse;

  getCart() async {
    emit(CartLoadingState());
    await CartRepo.getCart().then((value) {
      if (value != null) {
        cartResponse = value;
        emit(CartSuccessState());
      } else {
        emit(CartErrorState('error'));
      }
    });
  }

  removeFromCart(cartItemId) async {
    emit(CartLoadingState());

    await CartRepo.removeFromCart(cartItemId).then((value) {
      if (value != null) {
        cartResponse = value;
        emit(CartSuccessState());
      } else {
        emit(CartErrorState('error'));
      }
    });
  }

  updateCart(cartItemId, quantity) async {
    emit(CartLoadingState());

    await CartRepo.updateCart(cartItemId, quantity).then((value) {
      if (value != null) {
        cartResponse = value;
        emit(CartSuccessState());
      } else {
        emit(CartErrorState('error'));
      }
    });
  }

  Future<void> clearCart() async {
    try {
      final cartItems = cartResponse?.data?.cartItems ?? [];

      for (final cartItem in cartItems) {
        if (cartItem.itemId != null) {
          await CartRepo.removeFromCart(cartItem.itemId!);
        }
      }

      await getCart();
    } catch (e) {
      CartErrorState('Failed to clear cart ${e.toString()}');
    }
  }
}
