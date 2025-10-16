import 'package:flutter/material.dart';
import 'package:mailofly_android/app/components/app_drawer.dart';
import 'package:mailofly_android/app/components/custom_app_bar.dart';
import 'package:mailofly_android/app/pages/settings/language.dart';
import 'package:mailofly_android/app/pages/settings/notifications.dart';
import 'package:mailofly_android/app/pages/settings/security.dart';
import 'package:mailofly_android/app/pages/settings/theme.dart';
import 'package:mailofly_android/auth_gate.dart';
import 'package:mailofly_android/utils/supabase_user_util.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, required this.onSelectTab});
  final void Function(int) onSelectTab;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: CustomAppBar(title: 'Profile'),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(size.width * 0.05),
        child: Column(
          children: [
            _buildProfileCard(context),
            SizedBox(height: size.height * 0.03),
            _buildSettingsSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.all(size.width * 0.05),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF2D3748).withOpacity(0.8),
            const Color(0xFF4A5568).withOpacity(0.6),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        children: [
          Container(
            width: size.width * 0.2,
            height: size.width * 0.2,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF6C5CE7), Color(0xFFA29BFE)],
              ),
              borderRadius: BorderRadius.circular(size.width * 0.1),
            ),
            child: Icon(
              Icons.person,
              color: Colors.white,
              size: size.width * 0.1,
            ),
          ),
          SizedBox(height: size.height * 0.02),
          Text(
            'User',
            style: TextStyle(
              color: Colors.white,
              fontSize: size.width * 0.05,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'is829051977@gmail.com',
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: size.width * 0.035,
            ),
          ),
          SizedBox(height: size.height * 0.02),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.03,
              vertical: size.height * 0.005,
            ),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'FREE PLAN',
              style: TextStyle(
                color: Colors.green,
                fontSize: size.width * 0.03,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF2D3748).withOpacity(0.8),
            const Color(0xFF4A5568).withOpacity(0.6),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        children: [
          _buildSettingsItem(
            context,
            Icons.notifications,
            'Notifications',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (c) => NotificationSettingsPage()),
              );
            },
          ),
          _buildSettingsItem(
            context,
            Icons.security,
            'Security',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (c) => SecuritySettingsPage()),
              );
            },
          ),
          _buildSettingsItem(
            context,
            Icons.language,
            'Language',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (c) => LanguageSettingsPage()),
              );
            },
          ),
          _buildSettingsItem(
            context,
            Icons.dark_mode,
            'Theme',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (c) => ThemeSettingsPage()),
              );
            },
          ),
          _buildSettingsItem(
            context,
            Icons.logout,
            'Logout',
            isDestructive: true,
            onTap: () async {
              await SupabaseUserUtil.signOut();
              // ignore: use_build_context_synchronously
              Navigator.pushReplacement(
                // ignore: use_build_context_synchronously
                context,
                MaterialPageRoute(builder: (context) => AuthGate()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsItem(
    BuildContext context,
    IconData icon,
    String title, {
    bool isDestructive = false,
    VoidCallback? onTap,
  }) {
    final size = MediaQuery.of(context).size;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap ?? () {},
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05,
            vertical: size.height * 0.02,
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color:
                    isDestructive ? Colors.red : Colors.white.withOpacity(0.8),
                size: size.width * 0.05,
              ),
              SizedBox(width: size.width * 0.04),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: isDestructive ? Colors.red : Colors.white,
                    fontSize: size.width * 0.04,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: Colors.white.withOpacity(0.5),
                size: size.width * 0.04,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
