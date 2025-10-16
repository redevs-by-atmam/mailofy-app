import 'package:flutter/material.dart';
import 'package:mailofly_android/app/providers/user_profile_provider.dart';
import 'package:mailofly_android/app/pages/login.dart';
import 'package:mailofly_android/home_scaffold.dart';
import 'package:mailofly_android/utils/supabase_user_util.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: SupabaseUserUtil.authStateStream,
      builder: (context, snapshot) {
        // Show loading while connecting to auth stream
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // Check if user is authenticated
        final session = snapshot.hasData ? snapshot.data!.session : null;
        
        if (session != null) {
          return Consumer<UserProfileProvider>(
            builder: (context, userProfileProvider, child) {
              // Show loading while fetching user profile
              if (userProfileProvider.isLoading) {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }

              // Profile loaded successfully, show home
              return const HomeScaffold();
            },
          );
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
