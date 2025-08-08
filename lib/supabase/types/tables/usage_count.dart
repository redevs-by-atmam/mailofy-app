class UsageCounts {
  final int templates;
  final int campaigns;
  final int accounts;
  final int folders;
  final int contacts;

  UsageCounts({
    required this.templates,
    required this.campaigns,
    required this.accounts,
    required this.folders,
    required this.contacts,
  });

  factory UsageCounts.fromJson(Map<String, dynamic> json) {
    return UsageCounts(
      templates: json['templates'] ?? 0,
      campaigns: json['campaigns'] ?? 0,
      accounts: json['accounts'] ?? 0,
      folders: json['folders'] ?? 0,
      contacts: json['contacts'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'templates': templates,
      'campaigns': campaigns,
      'accounts': accounts,
      'folders': folders,
      'contacts': contacts,
    };
  }
}
