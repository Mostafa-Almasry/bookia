import 'dart:developer';

import 'package:bookia/core/constants/app_endpoints.dart';
import 'package:bookia/core/services/dio_provider.dart';
import 'package:bookia/core/services/local_helper.dart';
import 'package:bookia/feature/Cart/data/models/get_Cart_response/get_Cart_response.dart';

class CartRepo {
  static Future<GetCartResponse?> getCart() async {
    try {
      var response = await DioProvider.get(
        endpoint: AppEndpoints.cart,
        headers: {
          'Authorization':
              'Bearer ${AppLocalStorage.getCachedData(AppLocalStorage.tokenKey)}',
        },
      );

      if (response.statusCode == 200) {
        return GetCartResponse.fromJson(response.data);
      } else {
        return null;
      }
    } on Exception catch (e) {
      log("❌ get Cart error: ${e.toString()}");
      return null;
    }
  }

  static Future<bool> addToCart(int productId) async {
    try {
      var response = await DioProvider.post(
        endpoint: AppEndpoints.addToCart,
        data: {"product_id": productId},
        headers: {
          'Authorization':
              'Bearer ${AppLocalStorage.getCachedData(AppLocalStorage.tokenKey)}',
        },
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } on Exception catch (e) {
      log("❌ add to Cart error: ${e.toString()}");
      return false;
    }
  }

  static Future<GetCartResponse?> removeFromCart(int cartItemId) async {
    try {
      var response = await DioProvider.post(
        endpoint: AppEndpoints.removeFromCart,
        data: {"cart_item_id": cartItemId},
        headers: {
          'Authorization':
              'Bearer ${AppLocalStorage.getCachedData(AppLocalStorage.tokenKey)}',
        },
      );

      if (response.statusCode == 200) {
        return GetCartResponse.fromJson(response.data);
      } else {}
    } on Exception catch (e) {
      log("❌ remove from Cart error: ${e.toString()}");
      return null;
    }
    return null;
  }

  static Future<GetCartResponse?> updateCart(
    int cartItemId,
    int quantity,
  ) async {
    try {
      var response = await DioProvider.post(
        endpoint: AppEndpoints.updateCart,
        data: {"cart_item_id": cartItemId, "quantity": quantity},
        headers: {
          'Authorization':
              'Bearer ${AppLocalStorage.getCachedData(AppLocalStorage.tokenKey)}',
        },
      );

      if (response.statusCode == 201) {
        return GetCartResponse.fromJson(response.data);
      } else {}
    } on Exception catch (e) {
      log("❌ update Cart error: ${e.toString()}");
      return null;
    }
    return null;
  }
}
