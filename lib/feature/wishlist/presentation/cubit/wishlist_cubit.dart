import 'package:bloc/bloc.dart';
import 'package:bookia/feature/cart/data/repo/cart_repo.dart';
import 'package:bookia/feature/wishlist/data/models/get_wishlist_response/get_wishlist_response.dart';
import 'package:bookia/feature/wishlist/data/repo/wishlist_repo.dart';

part 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  WishlistCubit() : super(WishlistInitial());

  GetWishlistResponse? wishlistResponse;

  getWishlist() async {
    emit(WishlistLoadingState());

    await WishlistRepo.getWishlist().then((value) {
      if (value != null) {
        wishlistResponse = value;
        emit(WishlistSuccessState());
      } else {
        emit(WishlistErrorState('error'));
      }
    });
  }

  removeFromWishlist(int productId) async {
    emit(WishlistLoadingState());

    await WishlistRepo.removeFromWishlist(productId).then((value) {
      if (value != null) {
        wishlistResponse = value;
        emit(WishlistSuccessState());
      } else {
        emit(WishlistErrorState('error'));
      }
    });
  }

  Future<void> addToCart(int productId) async {
    emit(AddToCartLoadingState());

    await CartRepo.addToCart(productId).then((value) {
      if (value) {
        emit(AddToCartSuccessState());
      } else {
        emit(AddToCartErrorState('error'));
      }
    });
  }
}
