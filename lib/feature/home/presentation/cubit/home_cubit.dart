import 'package:bookia/feature/cart/data/repo/cart_repo.dart';
import 'package:bookia/feature/home/data/models/get_all_products_response/get_all_products_response.dart';
import 'package:bookia/feature/home/data/models/get_best_seller_response/get_best_seller_response.dart';
import 'package:bookia/feature/home/data/models/get_slider_response/get_slider_response.dart';
import 'package:bookia/feature/home/data/models/product.dart';
import 'package:bookia/feature/home/data/repo/home_repo.dart';
import 'package:bookia/feature/wishlist/data/repo/wishlist_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  GetBestSellerResponse? bestSellerResponse;
  GetBestSellerResponse? newArrivalsResponse;
  GetSliderResponse? sliderResponse;
  GetAllProductsResponse? allProductsResponse;

  // Store last search results
  List<Product>? _lastSearchResults;
  bool _isSearchActive = false;

  // fetchHomeData() async {
  //   emit(HomeLoadedstate);

  //   var response = Future.value([await getBestSeller(), await getSliders()]);

  //   emit(HomeLoadedstate);
  // }

  Future<void> getBestSeller() async {
    emit(BestSellerLoadingState());

    await HomeRepo.getBestSellers().then((value) {
      if (value != null) {
        bestSellerResponse = value;
        emit(BestSellerLoadedState());
      } else {
        emit(BestSellerErrorState('error'));
      }
    });
  }

  Future<void> getAllProducts() async {
    emit(AllProductsLoadingState());

    await HomeRepo.getAllProducts().then((value) {
      if (value != null) {
        allProductsResponse = value;
        emit(AllProductsLoadedState());
      } else {
        emit(AllProductsErrorState('error'));
      }
    });
  }

  Future<void> getNewArrivals() async {
    emit(NewArrivalsLoadingState());

    await HomeRepo.getNewArrivals().then((value) {
      if (value != null) {
        newArrivalsResponse = value;
        emit(NewArrivalsLoadedState());
      } else {
        emit(NewArrivalsErrorState('error'));
      }
    });
  }

  Future<void> getSliders() async {
    emit(SliderLoadingState());

    await HomeRepo.getSliders().then((value) {
      if (value != null) {
        sliderResponse = value;
        emit(SliderLoadedState());
      } else {
        emit(SliderErrorState('error'));
      }
    });
  }

  Future<void> addToWishlist(int productId) async {
    emit(AddToWishlistCartLoadingState());

    await WishlistRepo.addToWishlist(productId).then((value) {
      if (value) {
        emit(AddToWishlistCartSuccessState('Added to Wishlist'));
      } else {
        emit(AddToWishlistCartErrorState('error'));
      }
    });
  }

  Future<void> addToCart(int productId) async {
    if (_isSearchActive && _lastSearchResults != null) {
      // Don't emit loading state, just call the repo
      final success = await CartRepo.addToCart(productId);
      // show a toast here using a callback or a state with a message
      if (success) {
        emit(
          SearchLoadedStateWithMessage(_lastSearchResults!, 'Added to Cart'),
        );
      } else {
        SearchLoadedStateWithMessage(
          _lastSearchResults!,
          'Failed to add to Cart',
        );
      }
      emit(SearchLoadedState(_lastSearchResults!));
    } else {
      emit(AddToWishlistCartLoadingState());
      final success = await CartRepo.addToCart(productId);
      if (success) {
        emit(AddToWishlistCartSuccessState('Added to Cart'));
      } else {
        emit(AddToWishlistCartErrorState('error'));
      }
    }
  }

  Future<void> searchProducts(String query) async {
    emit(SearchLoadingState());
    _isSearchActive = true;
    await HomeRepo.searchProducts(query).then((value) {
      if (value != null) {
        _lastSearchResults = value.data?.products ?? [];
        emit(SearchLoadedState(_lastSearchResults!));
      } else {
        emit(SearchErrorState('error'));
      }
    });
  }

  Future<void> showCategory(int id) async {
    emit(SearchLoadingState());
    _isSearchActive = true;

    await HomeRepo.showCategories(id).then((value) {
      if (value != null) {
        _lastSearchResults = value.data?.products ?? [];
        emit(SearchLoadedState(_lastSearchResults!));
      } else {
        emit(SearchErrorState('error'));
      }
    });
  }

  void clearSearchResults() {
    _isSearchActive = false;
    _lastSearchResults = null;
    emit(HomeInitial());
  }
}
