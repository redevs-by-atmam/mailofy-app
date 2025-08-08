import '../tables/plans.dart';
import '../tables/subscriptions.dart';
import '../tables/usage_count.dart';
import '../tables/user_settings.dart';

class UserProfileDetails {
  final String id;
  final String? email;
  final String? fullName;
  final String? company;
  final String? avatarUrl;
  final Map<String, dynamic>? billingAddress;
  final SubscriptionsRow? subscription;
  final PlansRow? plan;
  final UserSettingsRow? settings;
  final UsageCounts usage;

  UserProfileDetails({
    required this.id,
    this.email,
    this.fullName,
    this.company,
    this.avatarUrl,
    this.billingAddress,
    this.subscription,
    this.plan,
    this.settings,
    required this.usage,
  });

  factory UserProfileDetails.fromJson(Map<String, dynamic> json) {
    return UserProfileDetails(
      id: json['id'] as String,
      email: json['email'] as String?,
      fullName: json['full_name'] as String?,
      company: json['company'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      billingAddress: json['billing_address'] as Map<String, dynamic>?,
      subscription:
          json['subscription'] != null
              ? SubscriptionsRow.fromJson(json['subscription'])
              : null,
      plan: json['plan'] != null ? PlansRow.fromJson(json['plan']) : null,
      settings:
          json['settings'] != null
              ? UserSettingsRow.fromJson(json['settings'])
              : null,
      usage: UsageCounts.fromJson(json['usage']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'full_name': fullName,
      'company': company,
      'avatar_url': avatarUrl,
      'billing_address': billingAddress,
      'subscription': subscription?.toJson(),
      'plan': plan?.toJson(),
      'settings': settings?.toJson(),
      'usage': usage.toJson(),
    };
  }
}
