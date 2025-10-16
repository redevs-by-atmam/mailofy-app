import 'package:flutter/material.dart';
import 'package:mailofly_android/auth_gate.dart';
import 'package:mailofly_android/app/providers/user_profile_provider.dart';
import 'package:mailofly_android/utils/utils.dart';
import 'package:provider/provider.dart';

void main() async {
  await initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return UserProfileProvider();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const AuthGate(),
      ),
    );
  }
}
