import 'package:flutter/material.dart';
import 'package:mailofly_android/app/components/custom_app_bar.dart';
import 'package:mailofly_android/app/components/app_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.onSelectTab});
  final void Function(int) onSelectTab;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 600;
    final screenPadding = size.width * 0.05; // 5% of screen width

    return Scaffold(
      backgroundColor: const Color(0xFF0A0E1A),
      appBar: CustomAppBar(title: 'Mailofly'),
      drawer: AppDrawer(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0A0E1A), Color(0xFF1A1F2E), Color(0xFF0A0E1A)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: screenPadding.clamp(16.0, 32.0),
              vertical: size.height * 0.02,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context, isSmallScreen),
                SizedBox(height: size.height * 0.04),
                _buildUserCard(context),
                SizedBox(height: size.height * 0.04),
                _buildNavigationGrid(context, isSmallScreen),
                SizedBox(height: size.height * 0.05),
                _buildEmptyState(context),
                SizedBox(height: size.height * 0.04),
                _buildAnalyticsCards(context),
                SizedBox(height: size.height * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isSmallScreen) {
    final size = MediaQuery.of(context).size;

    if (isSmallScreen) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeaderText(context),
          SizedBox(height: size.height * 0.02),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _buildHeaderText(context)),
        SizedBox(width: size.width * 0.04),
      ],
    );
  }

  Widget _buildHeaderText(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final titleFontSize = (size.width * 0.07).clamp(24.0, 32.0);
    final subtitleFontSize = (size.width * 0.04).clamp(14.0, 18.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome back, User!',
          style: TextStyle(
            color: Colors.white,
            fontSize: titleFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: size.height * 0.005),
        Text(
          'Here\'s what\'s happening with your email campaigns',
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: subtitleFontSize,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildUserCard(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cardPadding = size.width * 0.05;
    final avatarSize = (size.width * 0.12).clamp(50.0, 70.0);

    return Container(
      padding: EdgeInsets.all(cardPadding.clamp(16.0, 24.0)),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF2D3748).withOpacity(0.8),
            const Color(0xFF4A5568).withOpacity(0.6),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: avatarSize,
            height: avatarSize,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF6C5CE7), Color(0xFFA29BFE)],
              ),
              borderRadius: BorderRadius.circular(avatarSize / 2),
            ),
            child: Icon(
              Icons.person,
              color: Colors.white,
              size: avatarSize * 0.5,
            ),
          ),
          SizedBox(width: size.width * 0.04),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'User',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: (size.width * 0.05).clamp(18.0, 22.0),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: size.height * 0.005),
                Wrap(
                  spacing: size.width * 0.02,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.02,
                        vertical: size.height * 0.002,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'FREE',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: (size.width * 0.03).clamp(10.0, 14.0),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        'is829051977@gmail.com',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: (size.width * 0.035).clamp(12.0, 16.0),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationGrid(BuildContext context, bool isSmallScreen) {
    final size = MediaQuery.of(context).size;
    final crossAxisCount = isSmallScreen ? 1 : 2;
    final childAspectRatio = isSmallScreen ? 4.0 : 2.2;
    final spacing = size.width * 0.04;

    final List<NavigationItem> items = [
      NavigationItem(
        icon: Icons.campaign,
        title: 'Campaigns',
        subtitle: 'Manage campaigns',
        color: const Color(0xFF3B82F6),
        onTap: () {
          onSelectTab(1);
        },
      ),
      NavigationItem(
        icon: Icons.people,
        title: 'Recipients',
        subtitle: 'Manage contacts',
        color: const Color(0xFF10B981),
        onTap: (){
          onSelectTab(2);
        }
      ),

      // NavigationItem(
      //   icon: Icons.description,
      //   title: 'Templates',
      //   subtitle: 'Email templates',
      //   color: const Color(0xFF8B5CF6),
      // ),
      // NavigationItem(
      //   icon: Icons.account_circle,
      //   title: 'Accounts',
      //   subtitle: 'Email accounts',
      //   color: const Color(0xFFF59E0B),
      // ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: spacing.clamp(12.0, 20.0),
        mainAxisSpacing: spacing.clamp(12.0, 20.0),
        childAspectRatio: childAspectRatio,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return _buildNavigationCard(context, item);
      },
    );
  }

  Widget _buildNavigationCard(BuildContext context, NavigationItem item) {
    final size = MediaQuery.of(context).size;
    final cardPadding = size.width * 0.04;
    final iconSize = (size.width * 0.08).clamp(35.0, 45.0);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF2D3748).withOpacity(0.8),
            const Color(0xFF4A5568).withOpacity(0.6),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            // Handle navigation tap
          },
          child: Padding(
            padding: EdgeInsets.all(cardPadding.clamp(12.0, 20.0)),
            child: Row(
              children: [
                Container(
                  width: iconSize,
                  height: iconSize,
                  decoration: BoxDecoration(
                    color: item.color,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    item.icon,
                    color: Colors.white,
                    size: iconSize * 0.5,
                  ),
                ),
                SizedBox(width: size.width * 0.03),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        item.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: (size.width * 0.04).clamp(14.0, 18.0),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: size.height * 0.003),
                      Text(
                        item.subtitle,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          fontSize: (size.width * 0.03).clamp(11.0, 14.0),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final containerPadding = size.width * 0.08;
    final iconSize = (size.width * 0.15).clamp(60.0, 100.0);

    return Container(
      padding: EdgeInsets.all(containerPadding.clamp(24.0, 40.0)),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF2D3748).withOpacity(0.4),
            const Color(0xFF4A5568).withOpacity(0.2),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
      ),
      child: Column(
        children: [
          Container(
            width: iconSize,
            height: iconSize,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(iconSize / 2),
            ),
            child: Icon(
              Icons.mail_outline,
              color: Colors.white.withOpacity(0.6),
              size: iconSize * 0.5,
            ),
          ),
          SizedBox(height: size.height * 0.03),
          Text(
            'No campaigns yet',
            style: TextStyle(
              color: Colors.white,
              fontSize: (size.width * 0.05).clamp(18.0, 24.0),
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: size.height * 0.01),
          Text(
            'Create your first campaign to see analytics and performance metrics here.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withOpacity(0.6),
              fontSize: (size.width * 0.04).clamp(14.0, 18.0),
            ),
          ),
          SizedBox(height: size.height * 0.03),
        ],
      ),
    );
  }

  Widget _buildAnalyticsCards(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final spacing = (size.width * 0.03).clamp(8.0, 16.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'What you\'ll be able to track',
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: (size.width * 0.04).clamp(14.0, 18.0),
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: size.height * 0.02),
        _buildResponsiveCardGrid(context, spacing),
      ],
    );
  }

  Widget _buildResponsiveCardGrid(BuildContext context, double spacing) {
    final analyticsData = [
      {
        'title': 'Performance',
        'icon': Icons.trending_up,
        'color': const Color(0xFF3B82F6),
      },
      {
        'title': 'Engagement',
        'icon': Icons.favorite,
        'color': const Color(0xFFEF4444),
      },
      {
        'title': 'Audience',
        'icon': Icons.visibility,
        'color': const Color(0xFF8B5CF6),
      },
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth;
        final cardMinWidth = 120.0;
        final cardMaxWidth = 200.0;

        // Calculate optimal number of columns
        int columns = 3;
        if (availableWidth < 400) {
          columns = 1;
        } else if (availableWidth < 600) {
          columns = 2;
        }

        // Calculate card width based on columns
        final totalSpacing = spacing * (columns - 1);
        final cardWidth = ((availableWidth - totalSpacing) / columns).clamp(
          cardMinWidth,
          cardMaxWidth,
        );

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          alignment: WrapAlignment.start,
          children:
              analyticsData.map((data) {
                return SizedBox(
                  width: columns == 1 ? double.infinity : cardWidth,
                  child: _buildAnalyticsCard(
                    context,
                    data['title'] as String,
                    data['icon'] as IconData,
                    data['color'] as Color,
                  ),
                );
              }).toList(),
        );
      },
    );
  }

  Widget _buildAnalyticsCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
  ) {
    final size = MediaQuery.of(context).size;
    final isCompactHeight = size.height < 600;

    return Container(
      constraints: BoxConstraints(
        minHeight: isCompactHeight ? 80 : 100,
        maxHeight: isCompactHeight ? 120 : 140,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: (size.width * 0.04).clamp(12.0, 20.0),
        vertical: (size.height * 0.02).clamp(12.0, 16.0),
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF2D3748).withOpacity(0.6),
            const Color(0xFF4A5568).withOpacity(0.4),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: (size.width * 0.08).clamp(30.0, 45.0),
            height: (size.width * 0.08).clamp(30.0, 45.0),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(
                (size.width * 0.08).clamp(30.0, 45.0) / 2,
              ),
            ),
            child: Icon(
              icon,
              color: color,
              size: (size.width * 0.04).clamp(15.0, 22.0),
            ),
          ),
          SizedBox(height: (size.height * 0.012).clamp(6.0, 10.0)),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: (size.width * 0.035).clamp(11.0, 15.0),
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class NavigationItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback? onTap;

  NavigationItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    this.onTap,
  });
}
