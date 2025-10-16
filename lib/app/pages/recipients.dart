// Recipients Page
import 'package:flutter/material.dart';
import 'package:mailofly_android/app/components/app_drawer.dart';
import 'package:mailofly_android/app/components/custom_app_bar.dart';

class RecipientsPage extends StatelessWidget {
  const RecipientsPage({super.key, required this.onSelectTab});
  final void Function(int) onSelectTab;

  // Dummy recipients data
  final List<Map<String, dynamic>> _dummyRecipients = const [
    {
      'name': 'John Doe (Dummy)',
      'email': 'john.doe@email.com',
      'avatar': 'J',
      'status': 'Active',
      'lastActive': '2 hours ago'
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: CustomAppBar(title: 'Recipients'),
      drawer: AppDrawer(),
      body: Column(
        children: [
          // Info banner
          Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.blue.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: Colors.blue,
                  size: 24,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your Recipients',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'All your email recipients will be displayed here. You can manage and organize them into folders.',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Recipients list
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: _dummyRecipients.length,
              itemBuilder: (context, index) {
                final recipient = _dummyRecipients[index];
                return Card(
                  margin: EdgeInsets.only(bottom: 12),
                  color: Colors.white.withOpacity(0.05),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: Colors.white.withOpacity(0.1),
                      width: 1,
                    ),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue.withOpacity(0.8),
                      radius: 24,
                      child: Text(
                        recipient['avatar'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(
                      recipient['name'],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 4),
                        Text(
                          recipient['email'],
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: recipient['status'] == 'Active' 
                                    ? Colors.green.withOpacity(0.2)
                                    : Colors.red.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                recipient['status'],
                                style: TextStyle(
                                  color: recipient['status'] == 'Active' 
                                      ? Colors.green
                                      : Colors.red,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Last active: ${recipient['lastActive']}',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: PopupMenuButton<String>(
                      icon: Icon(
                        Icons.more_vert,
                        color: Colors.white.withOpacity(0.6),
                      ),
                      color: Colors.grey[900],
                      onSelected: (value) {
                        // Handle menu actions
                        switch (value) {
                          case 'edit':
                            // TODO: Navigate to edit recipient
                            break;
                          case 'delete':
                            // TODO: Show delete confirmation
                            break;
                          case 'folder':
                            // TODO: Add to folder
                            break;
                        }
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 'edit',
                          child: Row(
                            children: [
                              Icon(Icons.edit, color: Colors.white, size: 20),
                              SizedBox(width: 8),
                              Text('Edit', style: TextStyle(color: Colors.white)),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: 'folder',
                          child: Row(
                            children: [
                              Icon(Icons.folder, color: Colors.white, size: 20),
                              SizedBox(width: 8),
                              Text('Add to Folder', style: TextStyle(color: Colors.white)),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(Icons.delete, color: Colors.red, size: 20),
                              SizedBox(width: 8),
                              Text('Delete', style: TextStyle(color: Colors.red)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      // TODO: Navigate to recipient details
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Tapped on ${recipient['name']}'),
                          backgroundColor: Colors.blue,
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          
          // Add recipient button
          Padding(
            padding: EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  // TODO: Navigate to add recipient page
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Add Recipient feature coming soon!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                icon: Icon(Icons.add, color: Colors.white),
                label: Text(
                  'Add New Recipient',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
