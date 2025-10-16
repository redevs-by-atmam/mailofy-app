import 'package:flutter/material.dart';
import 'package:mailofly_android/app/components/app_drawer.dart';
import 'package:mailofly_android/app/pages/all_pages.dart';
import 'package:mailofly_android/app/pages/profile.dart';
import 'package:mailofly_android/app/pages/recipients.dart';
import 'package:mailofly_android/utils/constants.dart';

class HomeScaffold extends StatefulWidget {
  const HomeScaffold({super.key});

  @override
  State<HomeScaffold> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<HomeScaffold> {
  int _currentIndex = 0;

  void selectTab(int index) => setState(() => _currentIndex = index);

  late final List<Widget> _pages = [
    DashboardPage(onSelectTab: selectTab),
    CampaignsPage(onSelectTab: selectTab),
    RecipientsPage(onSelectTab: selectTab),
    ProfilePage(onSelectTab: selectTab),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isWideScreen = size.width > 800;

    return Scaffold(
      key: homeScaffoldKey,
      backgroundColor: const Color(0xFF0A0E1A),
      // drawer: isWideScreen ? null : const AppDrawer(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0A0E1A), Color(0xFF1A1F2E), Color(0xFF0A0E1A)],
          ),
        ),
        child:
            isWideScreen
                ? Row(
                  children: [
                    const SizedBox(width: 280, child: AppDrawer()),
                    const VerticalDivider(width: 1, color: Colors.white12),
                    Expanded(child: _pages[_currentIndex]),
                  ],
                )
                : _pages[_currentIndex],
      ),
      bottomNavigationBar: isWideScreen ? null : _buildBottomNavBar(context),
    );
  }

  Widget _buildBottomNavBar(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF2D3748).withOpacity(0.95),
            const Color(0xFF4A5568).withOpacity(0.95),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedItemColor: const Color(0xFF6C5CE7),
        unselectedItemColor: Colors.white.withOpacity(0.6),
        selectedFontSize: size.width * 0.032,
        unselectedFontSize: size.width * 0.028,
        iconSize: size.width * 0.06,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.campaign),
            label: 'Campaigns',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Recipients',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
