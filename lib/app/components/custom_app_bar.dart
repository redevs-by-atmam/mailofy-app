import 'package:flutter/material.dart';
import 'package:mailofly_android/app/components/user_avatar.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? subtitle;
  final bool showDrawerIcon;
  final VoidCallback? onProfileTap;
  final VoidCallback? onNotificationTap;
  final List<Widget>? actions;

  const CustomAppBar({
    super.key,
    required this.title,
    this.subtitle,
    this.showDrawerIcon = true,
    this.onProfileTap,
    this.onNotificationTap,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isWideScreen = size.width > 800;
    
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF2D3748).withOpacity(0.95),
            const Color(0xFF4A5568).withOpacity(0.9),
            const Color(0xFF6C5CE7).withOpacity(0.1),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: size.height * 0.08,
        leading: showDrawerIcon && !isWideScreen
            ? Builder(
                builder: (context) => Container(
                  margin: EdgeInsets.all(size.width * 0.02),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.menu,
                      color: Colors.white,
                      size: size.width * 0.05,
                    ),
                    onPressed: () => Scaffold.of(context).openDrawer(),
                  ),
                ),
              )
            : null,
        automaticallyImplyLeading: false,
        title: _buildTitle(context),
        actions: [
          ...?actions,
          _buildNotificationButton(context),
          SizedBox(width: size.width * 0.02),
          _buildProfileButton(context),
          SizedBox(width: size.width * 0.04),
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF2D3748).withOpacity(0.95),
                const Color(0xFF4A5568).withOpacity(0.9),
                const Color(0xFF6C5CE7).withOpacity(0.1),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Container(
              width: size.width * 0.01,
              height: size.height * 0.025,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6C5CE7), Color(0xFFA29BFE)],
                ),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(width: size.width * 0.03),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: (size.width * 0.045).clamp(18.0, 24.0),
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        if (subtitle != null) ...[
          SizedBox(height: size.height * 0.002),
          Padding(
            padding: EdgeInsets.only(left: size.width * 0.04),
            child: Text(
              subtitle!,
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: (size.width * 0.03).clamp(11.0, 14.0),
                fontWeight: FontWeight.w400,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildNotificationButton(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * 0.015),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 0.5,
        ),
      ),
      child: Stack(
        children: [
          IconButton(
            icon: Icon(
              Icons.notifications_outlined,
              color: Colors.white.withOpacity(0.9),
              size: size.width * 0.05,
            ),
            onPressed: onNotificationTap ?? () => _showComingSoon(context),
          ),
          Positioned(
            right: size.width * 0.02,
            top: size.height * 0.008,
            child: Container(
              width: size.width * 0.02,
              height: size.width * 0.02,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFEF4444), Color(0xFFDC2626)],
                ),
                borderRadius: BorderRadius.circular(size.width * 0.01),
                border: Border.all(color: Colors.white, width: 1),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileButton(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final avatarSize = (size.width * 0.09).clamp(35.0, 50.0);
    
    return GestureDetector(
      onTap: onProfileTap ?? () => _navigateToProfile(context),
      child: Container(
        padding: EdgeInsets.all(size.width * 0.005),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFF6C5CE7).withOpacity(0.8),
              const Color(0xFFA29BFE).withOpacity(0.8),
            ],
          ),
          borderRadius: BorderRadius.circular(avatarSize / 2),
          border: Border.all(
            color: Colors.white.withOpacity(0.3),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF6C5CE7).withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: SupabaseUserAvatar(avatarSize: avatarSize)
      ),
    );
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
  }

  void _navigateToProfile(BuildContext context) {
    // final mainState = context.findAncestorStateOfType<_MainHomePageState>();
    // mainState?.setState(() {
      // mainState._currentIndex = 3; // Navigate to profile page
    // });
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight * 1.2);
}
