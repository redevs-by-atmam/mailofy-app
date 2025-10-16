// widgets/supabase_user_avatar.dart
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mailofly_android/utils/supabase_user_util.dart';

class SupabaseUserAvatar extends StatelessWidget {
  final double avatarSize;
  final VoidCallback? onTap;
  final bool showOnlineIndicator;
  final EdgeInsets? padding;

  const SupabaseUserAvatar({
    super.key,
    required this.avatarSize,
    this.onTap,
    this.showOnlineIndicator = false,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel?>(
      future: SupabaseUserUtil.getCurrentUser(),
      builder: (context, snapshot) {
        final user = snapshot.data;
        
        return GestureDetector(
          onTap: onTap,
          child: Container(
            padding: padding ?? EdgeInsets.all(MediaQuery.of(context).size.width * 0.005),
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
            child: Stack(
              children: [
                CircleAvatar(
                  radius: (avatarSize - 6) / 2,
                  backgroundColor: Colors.transparent,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular((avatarSize - 6) / 2),
                    child: _buildAvatarContent(context, user),
                  ),
                ),
                if (showOnlineIndicator && user != null)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: avatarSize * 0.25,
                      height: avatarSize * 0.25,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(avatarSize * 0.125),
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAvatarContent(BuildContext context, UserModel? user) {
    if (user?.avatarUrl?.isNotEmpty == true) {
      return CachedNetworkImage(
        imageUrl: user!.avatarUrl!,
        fit: BoxFit.cover,
        width: avatarSize - 6,
        height: avatarSize - 6,
        placeholder: (context, url) => _buildPlaceholder(context, user),
        errorWidget: (context, url, error) => _buildPlaceholder(context, user),
      );
    }
    
    return _buildPlaceholder(context, user);
  }

  Widget _buildPlaceholder(BuildContext context, UserModel? user) {
    return Container(
      width: avatarSize - 6,
      height: avatarSize - 6,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF6C5CE7).withOpacity(0.3),
            const Color(0xFFA29BFE).withOpacity(0.3),
          ],
        ),
      ),
      child: user != null
          ? Center(
              child: Text(
                user.initials,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: avatarSize * 0.35,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : Icon(
              Icons.person,
              color: Colors.white,
              size: avatarSize * 0.5,
            ),
    );
  }
}
