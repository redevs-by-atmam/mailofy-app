import 'package:flutter/material.dart';
import 'package:mailofly_android/home.dart';
import 'package:mailofly_android/providers/user_profile_provider.dart';
import 'package:mailofly_android/screens/login.dart';
import 'package:provider/provider.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final session = Supabase.instance.client.auth.currentSession;

    if (session != null) {
      return Consumer<UserProfileProvider>(
        builder: (context, userProfileProvider, child) {
          // Show loading while fetching user profile
          if (userProfileProvider.isLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          // Show error state if profile fetch failed
          // if (userProfileProvider.hasError) {
          //   return Scaffold(
          //     body: Center(
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           const Icon(Icons.error, size: 64, color: Colors.red),
          //           const SizedBox(height: 16),
          //           Text(
          //             'Error loading profile: ${userProfileProvider.errorMessage}',
          //           ),
          //           const SizedBox(height: 16),
          //           ElevatedButton(
          //             onPressed: () => userProfileProvider.refreshUserProfile(),
          //             child: const Text('Retry'),
          //           ),
          //         ],
          //       ),
          //     ),
          //   );
          // }

          // Profile loaded successfully, show home
          return const Home();
        },
      );
    } else {
      return const LoginPage();
    }
  }
}
