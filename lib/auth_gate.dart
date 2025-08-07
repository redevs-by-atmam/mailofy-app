import 'package:flutter/material.dart';
import 'package:mailofly_android/home.dart';
import 'package:mailofly_android/screens/login.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final session = Supabase.instance.client.auth.currentSession;

    if (session != null) {
      return const Home();
    } else {
      return const LoginPage();
    }
  }
}
