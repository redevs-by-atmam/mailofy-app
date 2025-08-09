import 'package:mailofly_android/services/api_service.dart';
import 'package:mailofly_android/supabase/types/tables/templates.dart';
import 'package:mailofly_android/utils/api_response_model.dart';

class TemplateService {
  final ApiClient apiClient;
  const TemplateService(this.apiClient);

  Future<ApiResponse<List<TemplatesRow>>> getTemplates() async {
    final response = await apiClient.dio.get('/templates');
    final apiResponse = ApiResponse<List<TemplatesRow>>(
      success: response.data['success'],
      data:
          (response.data['data'] as List)
              .map((v) => TemplatesRow.fromJson(v))
              .toList(),
      error: response.data['error'] != null ? ApiError.fromJson(response.data['error']) : null,
    );
    return apiResponse;
  }

  Future<ApiResponse<TemplatesRow>> getTemplate(String id) {
    return apiClient.getParsed<TemplatesRow>(
      '/templates/$id',
      fromJsonT: (json) => TemplatesRow.fromJson(json as Map<String, dynamic>),
    );
  }
}
