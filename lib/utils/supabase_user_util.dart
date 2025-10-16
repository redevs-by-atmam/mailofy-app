// utils/supabase_user_util.dart
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';

class UserModel {
  final String id;
  final String? email;
  final String? phone;
  final String? displayName;
  final String? avatarUrl;

  UserModel({
    required this.id,
    this.email,
    this.phone,
    this.displayName,
    this.avatarUrl,
  });

  factory UserModel.fromSupabaseUser(
    User user, [
    Map<String, dynamic>? profileData,
  ]) {
    return UserModel(
      id: user.id,
      email: user.email,
      phone: user.phone,
      displayName: user.userMetadata?['display_name'],
      avatarUrl: user.userMetadata?['avatar_url'],
    );
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      email: map['email'],
      phone: map['phone'],
      displayName: map['display_name'] ?? map['username'],
      avatarUrl: map['avatar_url'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'phone': phone,
      'display_name': displayName,
      'avatar_url': avatarUrl,
    };
  }

  String get initials {
    if (displayName?.isNotEmpty == true) {
      final names = displayName!.split(' ');
      if (names.length >= 2) {
        return '${names.first[0]}${names.last[0]}'.toUpperCase();
      }
      return displayName![0].toUpperCase();
    }
    if (email?.isNotEmpty == true) {
      return email![0].toUpperCase();
    }
    return 'U';
  }

  String get displayText {
    return displayName ?? email?.split('@').first ?? 'User';
  }
}

class SupabaseUserUtil {
  static final SupabaseClient _supabase = Supabase.instance.client;

  // Get current Supabase user
  static User? get currentSupabaseUser => _supabase.auth.currentUser;

  // Check if user is logged in
  static bool get isLoggedIn => _supabase.auth.currentUser != null;

  // Get current session
  static Session? get currentSession => _supabase.auth.currentSession;

  // Get auth state stream
  static Stream<AuthState> get authStateStream =>
      _supabase.auth.onAuthStateChange;

  // Get current user as UserModel
  static Future<UserModel?> getCurrentUser() async {
    try {
      final User? supabaseUser = _supabase.auth.currentUser;
      if (supabaseUser == null) return null;

      // Try to get additional profile data from profiles table
      Map<String, dynamic>? profileData;
      try {
        final response =
            await _supabase
                .from('users')
                .select()
                .eq('id', supabaseUser.id)
                .maybeSingle();

        profileData = response;
      } catch (e) {
        debugPrint('Error fetching profile data: $e');
      }

      return UserModel.fromSupabaseUser(supabaseUser, profileData);
    } catch (e) {
      debugPrint('Error getting current user: $e');
      return null;
    }
  }

  // Get current user stream as UserModel

  // Update user profile

  // Sign out
  static Future<void> signOut() async {
    try {
      await _supabase.auth.signOut();
    } catch (e) {
      debugPrint('Error signing out: $e');
    }
  }
}
