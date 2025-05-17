import 'dart:developer';

import 'package:bookia/core/constants/app_endpoints.dart';
import 'package:bookia/core/services/dio_provider.dart';
import 'package:bookia/core/services/local_helper.dart';
import 'package:bookia/feature/profile/data/model/change_password/change_password.dart';
import 'package:bookia/feature/profile/data/model/contact_us/contact_us_request.dart';
import 'package:bookia/feature/profile/data/model/get_profile/get_profile_response.dart';
import 'package:bookia/feature/profile/data/model/update_profile/update_profile.dart';

class ProfileRepo {
  static Future<GetProfileResponse?> getProfile() async {
    try {
      var response = await DioProvider.get(
        endpoint: AppEndpoints.profile,
        headers: {
          'Authorization':
              'Bearer ${AppLocalStorage.getCachedData(AppLocalStorage.tokenKey)}',
        },
      );

      if (response.statusCode == 200) {
        return GetProfileResponse.fromJson(response.data);
      } else {
        return null;
      }
    } on Exception catch (e) {
      log("❌ get profile error: ${e.toString()}");
      return null;
    }
  }

  static Future<GetProfileResponse?> updateProfile(UpdateProfile data) async {
    try {
      var response = await DioProvider.post(
        endpoint: AppEndpoints.updateProfile,
        headers: {
          'Authorization':
              'Bearer ${AppLocalStorage.getCachedData(AppLocalStorage.tokenKey)}',
        },
        data: data.toJson(),
      );

      if (response.statusCode == 200) {
        return GetProfileResponse.fromJson(response.data);
      } else {
        return null;
      }
    } on Exception catch (e) {
      log("❌ get profile error: ${e.toString()}");
      return null;
    }
  }

  static Future<GetProfileResponse?> changePassword(
    ChangePasswordRequest data,
  ) async {
    try {
      var response = await DioProvider.post(
        endpoint: AppEndpoints.updatePassword,
        headers: {
          'Authorization':
              'Bearer ${AppLocalStorage.getCachedData(AppLocalStorage.tokenKey)}',
        },
        data: data.toJson(),
      );

      if (response.statusCode == 200) {
        AppLocalStorage.getCachedData(AppLocalStorage.tokenKey);
        return (GetProfileResponse.fromJson(response.data));
      } else {
        return null;
      }
    } on Exception catch (e) {
      log("❌ get profile error: ${e.toString()}");
      return null;
    }
  }

  static Future<bool?> contactUs(ContactUsRequest data) async {
    try {
      var response = await DioProvider.post(
        endpoint: AppEndpoints.contactUs,
        headers: {
          'Authorization':
              'Bearer ${AppLocalStorage.getCachedData(AppLocalStorage.tokenKey)}',
        },
        data: data.toJson(),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on Exception catch (e) {
      log("❌ contact us error: ${e.toString()}");
      return null;
    }
  }
}
