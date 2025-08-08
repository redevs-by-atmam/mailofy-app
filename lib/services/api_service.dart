// lib/api/mailofly_api_client.dart

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mailofly_android/utils/api_response_model.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

class ApiClient {
  final Dio dio = Dio();
  final SupabaseClient supabase = Supabase.instance.client;

  ApiClient() {
    dio.options.baseUrl = 'https://www.mailofly.com/api';
    dio.interceptors.add(PrettyDioLogger(requestHeader: true));
    print(dio.options.headers);
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final accessToken = supabase.auth.currentSession?.accessToken;
          if (accessToken != null) {
            options.headers['Authorization'] = 'Bearer $accessToken';
          }
          return handler.next(options);
        },
        onError: (error, handler) {
          debugPrint(
            "API Error: ${error.response?.statusCode} - ${error.message}",
          );
          return handler.next(error);
        },
      ),
    );
  }
}

extension ApiClientExtensions on ApiClient {
  Future<ApiResponse<T>> getParsed<T>(
    String path, {
    required T Function(Map<String, dynamic>? json) fromJsonT,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final response = await dio.get(path, queryParameters: queryParams);
      return ApiResponse<T>.fromJson(response.data, fromJsonT);
    } on DioException catch (e) {
      final errorData = e.response?.data;
      return ApiResponse<T>(
        success: false,
        error:
            errorData is Map<String, dynamic>
                ? ApiError.fromJson(errorData['error'])
                : ApiError(
                  code: e.response?.statusCode.toString() ?? 'unknown',
                  message: e.message ?? 'Error',
                ),
      );
    } catch (e) {
      return ApiResponse<T>(
        success: false,
        error: ApiError(code: 'unknown', message: e.toString()),
      );
    }
  }

  Future<ApiResponse<List<T>>> getParsedList<T>(
    String path, {
    required T Function(Map<String, dynamic> json) fromJsonT,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final response = await dio.get(path, queryParameters: queryParams);
      return ApiResponse<List<T>>.fromJson(
        response.data,
        (json) =>
            (json as List<dynamic>)
                .map((item) => fromJsonT(item as Map<String, dynamic>))
                .toList(),
      );
    } on DioException catch (e) {
      final errorData = e.response?.data;
      return ApiResponse<List<T>>(
        success: false,
        error:
            errorData is Map<String, dynamic>
                ? ApiError.fromJson(errorData['error'])
                : ApiError(
                  code: e.response?.statusCode.toString() ?? 'unknown',
                  message: e.message ?? 'Error',
                ),
      );
    } catch (e) {
      return ApiResponse<List<T>>(
        success: false,
        error: ApiError(code: 'unknown', message: e.toString()),
      );
    }
  }

  Future<ApiResponse<T>> postParsed<T>(
    String path, {
    required T Function(Object? json) fromJsonT,
    Map<String, dynamic>? body,
  }) async {
    try {
      final response = await dio.post(path, data: body);
      return ApiResponse<T>.fromJson(response.data, fromJsonT);
    } on DioException catch (e) {
      final errorData = e.response?.data;
      return ApiResponse<T>(
        success: false,
        error:
            errorData is Map<String, dynamic>
                ? ApiError.fromJson(errorData['error'])
                : ApiError(
                  code: e.response?.statusCode.toString() ?? 'unknown',
                  message: e.message ?? 'Error',
                ),
      );
    } catch (e) {
      return ApiResponse<T>(
        success: false,
        error: ApiError(code: 'unknown', message: e.toString()),
      );
    }
  }

  Future<ApiResponse<T>> putParsed<T>(
    String path, {
    required T Function(Object? json) fromJsonT,
    Map<String, dynamic>? body,
  }) async {
    try {
      final response = await dio.put(path, data: body);
      return ApiResponse<T>.fromJson(response.data, fromJsonT);
    } on DioException catch (e) {
      final errorData = e.response?.data;
      return ApiResponse<T>(
        success: false,
        error:
            errorData is Map<String, dynamic>
                ? ApiError.fromJson(errorData['error'])
                : ApiError(
                  code: e.response?.statusCode.toString() ?? 'unknown',
                  message: e.message ?? 'Error',
                ),
      );
    } catch (e) {
      return ApiResponse<T>(
        success: false,
        error: ApiError(code: 'unknown', message: e.toString()),
      );
    }
  }

  Future<ApiResponse<T>> deleteParsed<T>(
    String path, {
    required T Function(Object? json) fromJsonT,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final response = await dio.delete(path, queryParameters: queryParams);
      return ApiResponse<T>.fromJson(response.data, fromJsonT);
    } on DioException catch (e) {
      final errorData = e.response?.data;
      return ApiResponse<T>(
        success: false,
        error:
            errorData is Map<String, dynamic>
                ? ApiError.fromJson(errorData['error'])
                : ApiError(
                  code: e.response?.statusCode.toString() ?? 'unknown',
                  message: e.message ?? 'Error',
                ),
      );
    } catch (e) {
      return ApiResponse<T>(
        success: false,
        error: ApiError(code: 'unknown', message: e.toString()),
      );
    }
  }
}
