import 'dart:developer';

import 'package:bookia/core/constants/app_endpoints.dart';
import 'package:bookia/core/services/dio_provider.dart';
import 'package:bookia/feature/home/data/models/get_all_products_response/get_all_products_response.dart';
import 'package:bookia/feature/home/data/models/get_best_seller_response/get_best_seller_response.dart';
import 'package:bookia/feature/home/data/models/get_slider_response/get_slider_response.dart';
import 'package:bookia/feature/home/data/models/search_response/search_response.dart';

class HomeRepo {
  static Future<GetBestSellerResponse?> getBestSellers() async {
    try {
      var repsonse = await DioProvider.get(
        endpoint: AppEndpoints.getBestSellers,
      );

      if (repsonse.statusCode == 200) {
        return GetBestSellerResponse.fromJson(repsonse.data);
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
    }
    return null;
  }

  static Future<GetBestSellerResponse?> getNewArrivals() async {
    try {
      var repsonse = await DioProvider.get(
        endpoint: AppEndpoints.getNewArrivals,
      );

      if (repsonse.statusCode == 200) {
        return GetBestSellerResponse.fromJson(repsonse.data);
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
    }
    return null;
  }

  static Future<GetSliderResponse?> getSliders() async {
    try {
      var repsonse = await DioProvider.get(endpoint: AppEndpoints.getSliders);

      if (repsonse.statusCode == 200) {
        return GetSliderResponse.fromJson(repsonse.data);
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
    }
    return null;
  }

  static Future<GetAllProductsResponse?> getAllProducts() async {
    try {
      var repsonse = await DioProvider.get(
        endpoint: AppEndpoints.getAllProducts,
      );

      if (repsonse.statusCode == 200) {
        return GetAllProductsResponse.fromJson(repsonse.data);
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
    }
    return null;
  }

  static Future<SearchResponse?> searchProducts(String query) async {
    try {
      var repsonse = await DioProvider.get(
        endpoint: 'https://codingarabic.online/api/products-search?name=$query',
      );

      if (repsonse.statusCode == 200) {
        return SearchResponse.fromJson(repsonse.data);
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
    }
    return null;
  }

  static Future<SearchResponse?> showCategories(int id) async {
    try {
      var repsonse = await DioProvider.get(
        endpoint: "${AppEndpoints.showCategories}/$id",
      );

      if (repsonse.statusCode == 200) {
        return SearchResponse.fromJson(repsonse.data);
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
    }
    return null;
  }
}
