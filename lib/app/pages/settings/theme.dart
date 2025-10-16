import 'package:flutter/material.dart';

class ThemeSettingsPage extends StatelessWidget {
  const ThemeSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text('Theme', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF1E1E1E),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue, width: 2),
              ),
              child: ListTile(
                leading: Icon(Icons.nightlight_round, color: Colors.blue),
                title: const Text('Dark Theme', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                subtitle: const Text('Currently selected', style: TextStyle(color: Colors.grey)),
                trailing: const Icon(Icons.check_circle, color: Colors.blue),
                onTap: () {},
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: Icon(Icons.light_mode, color: Colors.grey),
                title: const Text('Light Theme', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500)),
                subtitle: const Text('Coming Soon', style: TextStyle(color: Colors.orangeAccent)),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Light theme will be available soon!'),
                      backgroundColor: Colors.orange,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
