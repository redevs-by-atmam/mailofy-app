class ApiResponse<T> {
  final bool success;
  final T? data;
  final ApiError? error;

  ApiResponse({required this.success, this.data, this.error});

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>? json)? fromJsonT,
  ) {
    return ApiResponse<T>(
      success: json['success'] as bool,
      data:
          json['data'] != null && fromJsonT != null
              ? fromJsonT(json['data'])
              : null,
      error:
          json['error'] != null
              ? ApiError.fromJson(json['error'] as Map<String, dynamic>)
              : null,
    );
  }

  Map<String, dynamic> toJson(Object? Function(T value)? toJsonT) {
    return {
      'success': success,
      if (data != null && toJsonT != null) 'data': toJsonT(data as T),
      if (error != null) 'error': error!.toJson(),
    };
  }
}

class ApiError {
  final String code;
  final String message;
  final dynamic details;

  ApiError({required this.code, required this.message, this.details});

  factory ApiError.fromJson(Map<String, dynamic> json) {
    return ApiError(
      code: json['code'] as String,
      message: json['message'] as String,
      details: json['details'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
      if (details != null) 'details': details,
    };
  }
}
