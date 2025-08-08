import 'package:flutter/material.dart';
import 'package:mailofly_android/services/api_service.dart';
import 'package:mailofly_android/services/user_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../supabase/types/functions/user_profile_details.dart';

enum UserProfileState { initial, loading, loaded, error }

class UserProfileProvider extends ChangeNotifier {
  final ApiClient ap;
  final UserService userService;
  final SupabaseClient _supabase = Supabase.instance.client;

  UserProfileDetails? _userProfile;
  UserProfileState _state = UserProfileState.initial;
  String? _errorMessage;

  // Getters
  UserProfileDetails? get userProfile => _userProfile;
  UserProfileState get state => _state;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _state == UserProfileState.loading;
  bool get hasError => _state == UserProfileState.error;
  bool get isLoaded => _state == UserProfileState.loaded;
  bool get hasUserProfile => _userProfile != null;

  UserProfileProvider(this.ap, this.userService) {
    _initializeAuthListener();
  }

  /// Initialize auth state listener to automatically fetch profile when user logs in
  void _initializeAuthListener() {
    _supabase.auth.onAuthStateChange.listen((data) {
      final session = data.session;
      if (session != null) {
        // User logged in, fetch profile
        fetchUserProfile();
      } else {
        // User logged out, clear profile
        _clearUserProfile();
      }
    });

    // Check if user is already logged in
    final currentSession = _supabase.auth.currentSession;
    if (currentSession != null) {
      fetchUserProfile();
    }
  }

  /// Fetch user profile details from the server
  Future<void> fetchUserProfile() async {
    try {
      _setState(UserProfileState.loading);
      _errorMessage = null;

      // final profile = await _apiClient.getUserProfile();
      _userProfile = null;
      _setState(UserProfileState.loaded);
    } catch (error) {
      _errorMessage = error.toString();
      _setState(UserProfileState.error);
      debugPrint('Error fetching user profile: $error');
    }
  }

  /// Refresh user profile data
  Future<void> refreshUserProfile() async {
    await fetchUserProfile();
  }

  /// Clear user profile data (used on logout)
  void _clearUserProfile() {
    _userProfile = null;
    _errorMessage = null;
    _setState(UserProfileState.initial);
  }

  /// Update profile state and notify listeners
  void _setState(UserProfileState newState) {
    _state = newState;
    notifyListeners();
  }

  /// Update specific user profile data (for optimistic updates)
  void updateUserProfile(UserProfileDetails updatedProfile) {
    _userProfile = updatedProfile;
    notifyListeners();
  }

  /// Get user display name (fallback logic)
  String get displayName {
    if (_userProfile == null) return 'User';
    return _userProfile!.fullName ??
        _userProfile!.email?.split('@').first ??
        'User';
  }

  /// Get user avatar URL or null
  String? get avatarUrl => _userProfile?.avatarUrl;

  /// Check if user has an active subscription
  bool get hasActiveSubscription => _userProfile?.subscription != null;

  /// Get current plan name
  String? get currentPlanName => _userProfile?.plan?.name;

  @override
  void dispose() {
    super.dispose();
  }
}
