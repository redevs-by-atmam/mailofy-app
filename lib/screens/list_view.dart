import 'package:flutter/material.dart';
import 'package:mailofly_android/home.dart';
import 'package:mailofly_android/screens/accounts.dart';
import 'package:mailofly_android/screens/campaigns.dart';
import 'package:mailofly_android/screens/templates.dart';

class CustomListView extends StatefulWidget {
  const CustomListView({super.key});

  @override
  State<CustomListView> createState() => _CustomListViewState();
}

class _CustomListViewState extends State<CustomListView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(15),
      children: [
        TaskCard(
          title: 'Campaign',
          description: 'Manage campaigns',
          color: Colors.red,
          iconData: Icons.campaign,
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CampaignsPage()),
            );
          },
        ),
        TaskCard(
          title: 'Recipients',
          description: 'Manage contacts',
          color: Colors.blue,
          iconData: Icons.people,
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const Home()),
            );
          },
        ),

        TaskCard(
          title: 'Templates',
          description: "Email templates",
          color: Colors.orange,
          iconData: Icons.email,
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const TemplatesPage()),
            );
          },
        ),

        TaskCard(
          title: 'Accounts',
          description: "Email accounts",
          color: Colors.green,
          iconData: Icons.account_box,
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AccountsPage()),
            );
          },
        ),
        // TaskCard(title: 'Learn Kotlin', description: '', color: Colors.purple),
      ],
    );
  }
}

class TaskCard extends StatelessWidget {
  final String title;
  final String description;
  final Color color;
  final IconData iconData;
  final VoidCallback? onTap;

  const TaskCard({
    super.key,
    required this.title,
    required this.description,
    required this.color,
    required this.iconData,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: Icon(iconData, color: color),
        title: Text(title),
        subtitle: Text(description),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
