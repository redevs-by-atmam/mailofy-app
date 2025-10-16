import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isWideScreen = size.width > 800;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF2D3748).withOpacity(0.95),
            const Color(0xFF4A5568).withOpacity(0.95),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border:
            isWideScreen
                ? const Border(right: BorderSide(color: Colors.white12))
                : null,
      ),
      child: SafeArea(
        child: Column(
          children: [
            _buildDrawerHeader(context),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.04,
                  vertical: size.height * 0.02,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildMainSection(context),
                    SizedBox(height: size.height * 0.03),
                    _buildManagementSection(context),
                    SizedBox(height: size.height * 0.03),
                    _buildRecipientsSection(context),
                    SizedBox(height: size.height * 0.03),
                    _buildSettingsSection(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerHeader(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.all(size.width * 0.05),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6C5CE7), Color(0xFFA29BFE)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: size.width * 0.12,
            height: size.width * 0.12,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular((size.width * 0.12) / 2),
            ),
            child: Icon(
              Icons.email,
              color: Colors.white,
              size: size.width * 0.06,
            ),
          ),
          SizedBox(width: size.width * 0.03),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Campaign Manager',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: size.width * 0.045,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Email Marketing Suite',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: size.width * 0.032,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainSection(BuildContext context) {
    return _buildSection(context, 'Main', [
      DrawerItem(
        icon: Icons.dashboard,
        title: 'Dashboard',
        onTap: () => _navigateToPage(context, 0),
      ),
      DrawerItem(
        icon: Icons.analytics,
        title: 'Analytics',
        onTap: () => _showComingSoon(context),
      ),
    ]);
  }

  Widget _buildManagementSection(BuildContext context) {
    return _buildSection(context, 'Management', [
      DrawerItem(
        icon: Icons.campaign,
        title: 'Campaigns',
        onTap: () => _navigateToPage(context, 1),
        hasSubmenu: true,
      ),
      DrawerItem(
        icon: Icons.description,
        title: 'Templates',
        onTap: () => _showComingSoon(context),
      ),
      DrawerItem(
        icon: Icons.account_circle,
        title: 'Accounts',
        onTap: () => _showComingSoon(context),
      ),
    ]);
  }

  Widget _buildRecipientsSection(BuildContext context) {
    return _buildSection(context, 'Recipients', [
      DrawerItem(
        icon: Icons.people,
        title: 'All Recipients',
        onTap: () => _navigateToPage(context, 2),
      ),
      DrawerItem(
        icon: Icons.folder,
        title: 'Folders',
        onTap: () => _showComingSoon(context),
        hasSubmenu: true,
      ),
      DrawerItem(
        icon: Icons.label,
        title: 'Tags',
        onTap: () => _showComingSoon(context),
      ),
      DrawerItem(
        icon: Icons.block,
        title: 'Suppressed',
        onTap: () => _showComingSoon(context),
      ),
    ]);
  }

  Widget _buildSettingsSection(BuildContext context) {
    return _buildSection(context, 'Settings', [
      DrawerItem(
        icon: Icons.person,
        title: 'Profile',
        onTap: () => _navigateToPage(context, 3),
      ),
      DrawerItem(
        icon: Icons.settings,
        title: 'Preferences',
        onTap: () => _showComingSoon(context),
      ),
      DrawerItem(
        icon: Icons.help,
        title: 'Help & Support',
        onTap: () => _showComingSoon(context),
      ),
    ]);
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    List<DrawerItem> items,
  ) {
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
          child: Text(
            title.toUpperCase(),
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: size.width * 0.028,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
            ),
          ),
        ),
        SizedBox(height: size.height * 0.01),
        ...items.map((item) => _buildDrawerItem(context, item)),
      ],
    );
  }

  Widget _buildDrawerItem(BuildContext context, DrawerItem item) {
    final size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * 0.003),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: item.onTap,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.04,
              vertical: size.height * 0.015,
            ),
            child: Row(
              children: [
                Icon(
                  item.icon,
                  color: Colors.white.withOpacity(0.8),
                  size: size.width * 0.05,
                ),
                SizedBox(width: size.width * 0.04),
                Expanded(
                  child: Text(
                    item.title,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: size.width * 0.038,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                if (item.hasSubmenu)
                  Icon(
                    Icons.chevron_right,
                    color: Colors.white.withOpacity(0.5),
                    size: size.width * 0.04,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToPage(BuildContext context, int index) {
    // final mainState = context.findAncestorStateOfType<_MainHomePageState>();
    // mainState?.setState(() {
    //   mainState._currentIndex = index;
    // });

    if (MediaQuery.of(context).size.width <= 800) {
      Navigator.of(context).pop();
    }
  }

  void _showComingSoon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Coming Soon!'),
        backgroundColor: const Color(0xFF6C5CE7),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );

    if (MediaQuery.of(context).size.width <= 800) {
      Navigator.of(context).pop();
    }
  }
}

class DrawerItem {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool hasSubmenu;

  DrawerItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.hasSubmenu = false,
  });
}
