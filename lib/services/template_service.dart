import 'package:mailofly_android/services/api_service.dart';
import 'package:mailofly_android/supabase/types/tables/templates.dart';
import 'package:mailofly_android/utils/api_response_model.dart';

class TemplateService {
  final ApiClient apiClient;
  const TemplateService(this.apiClient);

  Future<ApiResponse<List<TemplatesRow>>> getTemplates() {
    return apiClient.getParsedList<TemplatesRow>(
      '/templates',
      fromJsonT: (json) => TemplatesRow.fromJson(json),
    );
  }

  Future<ApiResponse<TemplatesRow>> getTemplate(String id) {
    return apiClient.getParsed<TemplatesRow>(
      '/templates/$id',
      fromJsonT: (json) => TemplatesRow.fromJson(json as Map<String, dynamic>),
    );
  }
}
