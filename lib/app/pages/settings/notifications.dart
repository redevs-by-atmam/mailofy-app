import 'package:flutter/material.dart';

class NotificationSettingsPage extends StatefulWidget {
  const NotificationSettingsPage({super.key});

  @override
  State<NotificationSettingsPage> createState() => _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  bool pushEnabled = true;
  bool emailEnabled = false;
  bool smsEnabled = false;

  void _showToast(String message, [Color? color]) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color ?? Colors.blue,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text('Notifications', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF1E1E1E),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildNotificationTile(
              icon: Icons.notifications,
              title: 'Push Notifications',
              value: pushEnabled,
              onChanged: (value) {
                setState(() { pushEnabled = value; });
                _showToast(value ? 'Push notifications enabled' : 'Push notifications disabled', value ? Colors.green : Colors.red);
              },
            ),
            const SizedBox(height: 16),
            _buildNotificationTile(
              icon: Icons.email,
              title: 'Email Notifications',
              value: emailEnabled,
              onChanged: (value) {
                setState(() { emailEnabled = value; });
                _showToast(value ? 'Email notifications enabled' : 'Email notifications disabled', value ? Colors.green : Colors.red);
              },
            ),
            const SizedBox(height: 16),
            _buildNotificationTile(
              icon: Icons.sms,
              title: 'SMS Notifications',
              value: smsEnabled,
              onChanged: (value) {
                setState(() { smsEnabled = value; });
                _showToast(value ? 'SMS notifications enabled' : 'SMS notifications disabled', value ? Colors.green : Colors.red);
              },
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text('Banners and promotional notifications coming soon!', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationTile({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
        trailing: Switch(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.blue,
          inactiveThumbColor: Colors.grey,
        ),
      ),
    );
  }
}
