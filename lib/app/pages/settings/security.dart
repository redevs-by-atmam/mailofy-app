import 'package:flutter/material.dart';

class SecuritySettingsPage extends StatefulWidget {
  const SecuritySettingsPage({super.key});

  @override
  State<SecuritySettingsPage> createState() => _SecuritySettingsPageState();
}

class _SecuritySettingsPageState extends State<SecuritySettingsPage> {
  bool biometricEnabled = false;
  bool twoFactorEnabled = true;
  bool autoLockEnabled = true;
  bool loginAlertsEnabled = false;
  bool deviceManagementEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text('Security', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF1E1E1E),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSecuritySection('Authentication', [
            _buildSecurityTile(
              icon: Icons.fingerprint,
              title: 'Biometric Authentication',
              subtitle: 'Use fingerprint or face ID to unlock',
              value: biometricEnabled,
              onChanged: (value) {
                setState(() {
                  biometricEnabled = value;
                });
                _showToast(value ? 'Biometric authentication enabled' : 'Biometric authentication disabled');
              },
            ),
            _buildSecurityTile(
              icon: Icons.security,
              title: 'Two-Factor Authentication',
              subtitle: 'Add an extra layer of security',
              value: twoFactorEnabled,
              onChanged: (value) {
                setState(() {
                  twoFactorEnabled = value;
                });
                _showToast(value ? 'Two-factor authentication enabled' : 'Two-factor authentication disabled');
              },
            ),
          ]),
          const SizedBox(height: 24),
          _buildSecuritySection('App Security', [
            _buildSecurityTile(
              icon: Icons.lock_clock,
              title: 'Auto Lock',
              subtitle: 'Lock app when inactive for 5 minutes',
              value: autoLockEnabled,
              onChanged: (value) {
                setState(() {
                  autoLockEnabled = value;
                });
                _showToast(value ? 'Auto lock enabled' : 'Auto lock disabled');
              },
            ),
            _buildSecurityTile(
              icon: Icons.devices,
              title: 'Device Management',
              subtitle: 'Manage trusted devices',
              value: deviceManagementEnabled,
              onChanged: (value) {
                setState(() {
                  deviceManagementEnabled = value;
                });
                _showToast(value ? 'Device management enabled' : 'Device management disabled');
              },
            ),
          ]),
          const SizedBox(height: 24),
          _buildSecuritySection('Alerts', [
            _buildSecurityTile(
              icon: Icons.notification_important,
              title: 'Login Alerts',
              subtitle: 'Get notified of new sign-ins',
              value: loginAlertsEnabled,
              onChanged: (value) {
                setState(() {
                  loginAlertsEnabled = value;
                });
                _showToast(value ? 'Login alerts enabled' : 'Login alerts disabled');
              },
            ),
          ]),
          const SizedBox(height: 32),
          // _buildActionButton(
          //   'Change Password',
          //   Icons.lock_reset,
          //   () => _showToast('Password change initiated'),
          // ),
          // const SizedBox(height: 16),
          // _buildActionButton(
          //   'Security Checkup',
          //   Icons.verified_user,
          //   () => _showToast('Security checkup completed'),
          // ),
        ],
      ),
    );
  }

  Widget _buildSecuritySection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 12),
          child: Text(title, style: const TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w500)),
        ),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildSecurityTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: Colors.blue, size: 20),
      ),
      title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
      subtitle: Text(subtitle, style: const TextStyle(color: Colors.grey)),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: Colors.blue,
        activeTrackColor: Colors.blue.withOpacity(0.3),
        inactiveThumbColor: Colors.grey,
        inactiveTrackColor: Colors.grey.withOpacity(0.3),
      ),
    );
  }


  void _showToast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.blue,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
