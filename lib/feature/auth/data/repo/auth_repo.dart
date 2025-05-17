import 'dart:developer';

import 'package:bookia/core/constants/app_endpoints.dart';
import 'package:bookia/core/services/dio_provider.dart';
import 'package:bookia/feature/auth/data/models/otp_verfication/send_forgot_password.dart';
import 'package:bookia/feature/auth/data/models/request/auth_params.dart';
import 'package:bookia/feature/auth/data/models/response/auth_response/auth_response.dart';

class AuthRepo {
  static Future<AuthResponse?> register(AuthParams params) async {
    try {
      var response = await DioProvider.post(
        endpoint: AppEndpoints.register,
        data: params.toJson(),
      );

      // Debug prints
      log("🔁 Register request sent: ${params.toJson()}");
      log("📦 Register response status: ${response.statusCode}");
      log("📥 Register response body: ${response.data}");

      if (response.statusCode == 201) {
        return AuthResponse.fromJson(response.data);
      } else {
        return null;
      }
    } on Exception catch (e) {
      log("❌ Register error: ${e.toString()}");
      return null;
    }
  }

  static Future<AuthResponse?> login(AuthParams params) async {
    try {
      var response = await DioProvider.post(
        endpoint: AppEndpoints.login,
        data: params.toJson(),
      );

      // 👇 Debug prints
      log("🔁 Login request sent: ${params.toJson()}");
      log("📦 Login response status: ${response.statusCode}");
      log("📥 Login response body: ${response.data}");

      if (response.statusCode == 200) {
        return AuthResponse.fromJson(response.data);
      } else {
        return null;
      }
    } on Exception catch (e) {
      log("❌ Login error: ${e.toString()}");
      return null;
    }
  }

  static Future<AuthResponse?> forgetPassword(SendForgetPassword email) async {
    try {
      var response = await DioProvider.post(
        endpoint: AppEndpoints.forgetPassword,
        data: email.toJson(),
      );

      if (response.statusCode == 200) {
        log('Forget Password Success: ${response.data}');
        return AuthResponse.fromJson(response.data);
      } else {
        log('Forget Password Error: ${response.data}');
        throw Exception(
          response.data['message'] ?? 'Failed to send reset code',
        );
      }
    } on Exception catch (e) {
      log('Forgot Password Exception: $e');
      rethrow;
    }
  }

  static Future<AuthResponse?> checkForgetPassword(
    CheckForgetPasswordCode data,
  ) async {
    try {
      var response = await DioProvider.post(
        endpoint: AppEndpoints.checkForgetPassword,
        data: data.toJson(),
      );

      if (response.statusCode == 200) {
        log('Check Forget Password Success: ${response.data}');
        return AuthResponse.fromJson(response.data);
      } else {
        log('Check Forget Password Error: ${response.data}');
        throw Exception(response.data['message'] ?? 'Error');
      }
    } on Exception catch (e) {
      log('Forget Password Exception: $e');
      rethrow;
    }
  }

  static Future<AuthResponse?> resetPassword(ResetPassword data) async {
    try {
      var response = await DioProvider.post(
        endpoint: AppEndpoints.resetPassword,
        data: data.toJson(),
      );

      if (response.statusCode == 200) {
        log('Reset Password Success: ${response.data}');
        return AuthResponse.fromJson(response.data);
      } else {
        log('Reset Password Error: ${response.data}');
        throw Exception(response.data['message'] ?? 'Error');
      }
    } on Exception catch (e) {
      log('Forget Password Exception: $e');
      rethrow;
    }
  }
}
