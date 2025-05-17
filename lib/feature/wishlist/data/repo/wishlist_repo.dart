import 'dart:developer';

import 'package:bookia/core/constants/app_endpoints.dart';
import 'package:bookia/core/services/dio_provider.dart';
import 'package:bookia/core/services/local_helper.dart';
import 'package:bookia/feature/wishlist/data/models/get_wishlist_response/get_wishlist_response.dart';

class WishlistRepo {
  static Future<GetWishlistResponse?> getWishlist() async {
    try {
      var response = await DioProvider.get(
        endpoint: AppEndpoints.getWishlist,
        headers: {
          'Authorization':
              'Bearer ${AppLocalStorage.getCachedData(AppLocalStorage.tokenKey)}',
        },
      );

      if (response.statusCode == 200) {
        return GetWishlistResponse.fromJson(response.data);
      } else {
        return null;
      }
    } on Exception catch (e) {
      log("❌ get Wishlist error: ${e.toString()}");
      return null;
    }
  }

  static Future<bool> addToWishlist(int productId) async {
    try {
      var response = await DioProvider.post(
        endpoint: AppEndpoints.addToWishlist,
        data: {"product_id": productId},
        headers: {
          'Authorization':
              'Bearer ${AppLocalStorage.getCachedData(AppLocalStorage.tokenKey)}',
        },
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on Exception catch (e) {
      log("❌ add to Wishlist error: ${e.toString()}");
      return false;
    }
  }

  static Future<GetWishlistResponse?> removeFromWishlist(int productId) async {
    try {
      var response = await DioProvider.post(
        endpoint: AppEndpoints.removeFromWishlist,
        data: {"product_id": productId},
        headers: {
          'Authorization':
              'Bearer ${AppLocalStorage.getCachedData(AppLocalStorage.tokenKey)}',
        },
      );

      if (response.statusCode == 200) {
        return GetWishlistResponse.fromJson(response.data);
      } else {}
    } on Exception catch (e) {
      log("❌ remove from Wishlist error: ${e.toString()}");
      return null;
    }
    return null;
  }
}
