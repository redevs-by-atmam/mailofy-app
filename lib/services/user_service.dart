import 'package:mailofly_android/services/api_service.dart';
import 'package:mailofly_android/supabase/types/functions/user_profile_details.dart';
import 'package:mailofly_android/utils/api_response_model.dart';

class UserService {
  final ApiClient api;
  const UserService(this.api);
  Future<ApiResponse<UserProfileDetails>> getUserDetails() async {
    final response = await api.supabase.functions.invoke('get_user_data');
    print(response.data);
    return ApiResponse(
      success: true,
      data: UserProfileDetails.fromJson(response.data),
      error: null,
    );
  }
}
