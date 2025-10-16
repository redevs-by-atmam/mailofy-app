// Dashboard Page (your existing HomePage)
import 'package:flutter/material.dart';
import 'package:mailofly_android/app/components/custom_app_bar.dart';
import 'package:mailofly_android/app/components/app_drawer.dart';
import 'package:mailofly_android/app/pages/dashboard.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key, required this.onSelectTab});
  final void Function(int) onSelectTab;

  @override
  Widget build(BuildContext context) {
    return HomePage(onSelectTab: onSelectTab); // Your existing HomePage widget
  }
}

// Campaigns Page

class CampaignsPage extends StatefulWidget {
  const CampaignsPage({super.key, required this.onSelectTab});
  final void Function(int) onSelectTab;

  @override
  State<CampaignsPage> createState() => _CampaignsPageState();
}

class _CampaignsPageState extends State<CampaignsPage> {
  // Dummy campaigns data with status tracking
  final List<Map<String, dynamic>> _campaigns = [
    {
      'id': '1',
      'name': 'Summer Sale 2025',
      'subject': 'Get 50% Off on All Products!',
      'recipients': 1250,
      'status': 'draft', // draft, running, paused, completed
      'openRate': 24.5,
      'clickRate': 8.2,
      'sentCount': 0,
      'scheduledDate': '2025-10-20',
      'description': 'Promote our summer collection with exclusive discounts'
    },
    {
      'id': '2',
      'name': 'Newsletter October',
      'subject': 'Monthly Updates & New Features',
      'recipients': 850,
      'status': 'running',
      'openRate': 31.2,
      'clickRate': 12.8,
      'sentCount': 623,
      'scheduledDate': '2025-10-15',
      'description': 'Regular monthly newsletter with updates'
    },
    {
      'id': '3',
      'name': 'Welcome Series',
      'subject': 'Welcome to Our Community!',
      'recipients': 420,
      'status': 'paused',
      'openRate': 45.8,
      'clickRate': 18.5,
      'sentCount': 210,
      'scheduledDate': '2025-10-10',
      'description': 'Automated welcome email series for new subscribers'
    },
    {
      'id': '4',
      'name': 'Product Launch',
      'subject': 'Introducing Our Latest Innovation',
      'recipients': 2100,
      'status': 'completed',
      'openRate': 38.7,
      'clickRate': 15.3,
      'sentCount': 2100,
      'scheduledDate': '2025-10-05',
      'description': 'Launch announcement for new product line'
    },
  ];

  void _showToast(String message, {Color backgroundColor = Colors.green}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        backgroundColor: backgroundColor,
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.all(16),
      ),
    );
  }

  void _toggleCampaignStatus(int index) {
    setState(() {
      final campaign = _campaigns[index];
      final currentStatus = campaign['status'];
      
      if (currentStatus == 'draft') {
        campaign['status'] = 'running';
        _showToast('Campaign "${campaign['name']}" has been started!');
      } else if (currentStatus == 'running') {
        campaign['status'] = 'paused';
        _showToast('Campaign "${campaign['name']}" has been paused!', backgroundColor: Colors.orange);
      } else if (currentStatus == 'paused') {
        campaign['status'] = 'running';
        _showToast('Campaign "${campaign['name']}" has been resumed!');
      }
    });
  }

  void _stopCampaign(int index) {
    setState(() {
      final campaign = _campaigns[index];
      campaign['status'] = 'completed';
      _showToast('Campaign "${campaign['name']}" has been stopped!', backgroundColor: Colors.red);
    });
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'draft':
        return Colors.grey;
      case 'running':
        return Colors.green;
      case 'paused':
        return Colors.orange;
      case 'completed':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  IconData _getActionIcon(String status) {
    switch (status) {
      case 'draft':
        return Icons.play_arrow;
      case 'running':
        return Icons.pause;
      case 'paused':
        return Icons.play_arrow;
      default:
        return Icons.refresh;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: CustomAppBar(title: 'Campaigns'),
      drawer: AppDrawer(),
      body: Column(
        children: [
          // Info banner
          Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.purple.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.purple.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.campaign,
                  color: Colors.purple,
                  size: 24,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Email Campaigns',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Create, manage and track your email marketing campaigns here.',
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

          // Campaigns list
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: _campaigns.length,
              itemBuilder: (context, index) {
                final campaign = _campaigns[index];
                final status = campaign['status'];
                
                return Card(
                  margin: EdgeInsets.only(bottom: 16),
                  color: Colors.white.withOpacity(0.05),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(
                      color: Colors.white.withOpacity(0.1),
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header with status
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                campaign['name'],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: _getStatusColor(status).withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                status.toUpperCase(),
                                style: TextStyle(
                                  color: _getStatusColor(status),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                        SizedBox(height: 8),
                        
                        // Subject
                        Text(
                          campaign['subject'],
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        
                        SizedBox(height: 8),
                        
                        // Description
                        Text(
                          campaign['description'],
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                            fontSize: 14,
                          ),
                        ),
                        
                        SizedBox(height: 16),
                        
                        // Stats row
                        Row(
                          children: [
                            Expanded(
                              child: _buildStatItem(
                                'Recipients',
                                campaign['recipients'].toString(),
                                Icons.people,
                              ),
                            ),
                            Expanded(
                              child: _buildStatItem(
                                'Sent',
                                campaign['sentCount'].toString(),
                                Icons.send,
                              ),
                            ),
                            Expanded(
                              child: _buildStatItem(
                                'Open Rate',
                                '${campaign['openRate']}%',
                                Icons.mark_email_read,
                              ),
                            ),
                            Expanded(
                              child: _buildStatItem(
                                'Click Rate',
                                '${campaign['clickRate']}%',
                                Icons.mouse,
                              ),
                            ),
                          ],
                        ),
                        
                        SizedBox(height: 16),
                        
                        // Action buttons
                        Row(
                          children: [
                            // Primary action button (Start/Pause/Resume)
                            if (status != 'completed')
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: () => _toggleCampaignStatus(index),
                                  icon: Icon(
                                    _getActionIcon(status),
                                    color: Colors.white,
                                  ),
                                  label: Text(
                                    status == 'draft'
                                        ? 'Start Campaign'
                                        : status == 'running'
                                            ? 'Pause'
                                            : 'Resume',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: status == 'running'
                                        ? Colors.orange
                                        : Colors.green,
                                    padding: EdgeInsets.symmetric(vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                            
                            if (status != 'completed') SizedBox(width: 12),
                            
                            // Stop button (only for running/paused campaigns)
                            if (status == 'running' || status == 'paused')
                              ElevatedButton.icon(
                                onPressed: () => _stopCampaign(index),
                                icon: Icon(Icons.stop, color: Colors.white),
                                label: Text(
                                  'Stop',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            
                            // View Details button for completed campaigns
                            if (status == 'completed')
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    _showToast('Viewing campaign details...', backgroundColor: Colors.blue);
                                  },
                                  icon: Icon(Icons.analytics, color: Colors.white),
                                  label: Text(
                                    'View Details',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    padding: EdgeInsets.symmetric(vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          
          // Create campaign button
          Padding(
            padding: EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  _showToast('Create Campaign feature coming soon!', backgroundColor: Colors.purple);
                },
                icon: Icon(Icons.add, color: Colors.white),
                label: Text(
                  'Create New Campaign',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
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

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white.withOpacity(0.6),
          size: 20,
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.6),
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

// Profile Page
