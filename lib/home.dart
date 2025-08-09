import 'package:flutter/material.dart';
import 'package:mailofly_android/screens/profile.dart';
import 'package:mailofly_android/screens/templates.dart';
import 'package:mailofly_android/services/api_service.dart';
import 'package:mailofly_android/services/user_service.dart';
import 'package:mailofly_android/supabase/types/functions/user_profile_details.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late UserProfileDetails user;

  @override
  void initState() {
    Future.microtask(() async {
      final api = ApiClient();
      final userService = UserService(api);
      final response = await userService.getUserDetails();
      if (response.success) user = response.data!;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final session = Supabase.instance.client.auth.currentSession;
    final accessToken = session?.accessToken ?? 'Not available';
    final email = session?.user.email ?? 'Unknown';

    return Scaffold(
      appBar: AppBar(title: const Text('Mailofly')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.blue),
              child: Text(
                'HelloW, $email',
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProfilePage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('templates'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const TemplatesPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SelectableText(
            'Access Token:\n$accessToken',
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ),
    );
  }
}
