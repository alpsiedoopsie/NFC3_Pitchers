import 'package:flutter/material.dart';

class LawEnforcementInterface extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Law Enforcement Dashboard'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Dashboard'),
              Tab(text: 'Incidents'),
              Tab(text: 'Notifications'),
              Tab(text: 'Analytics'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildDashboard(),
            _buildIncidentManagement(),
            _buildNotifications(),
            _buildAnalytics(),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboard() {
    return Center(
      child: Text('Dashboard Overview'),
    );
  }

  Widget _buildIncidentManagement() {
    return ListView(
      children: [
        ListTile(
          title: Text('Incident 1'),
          subtitle: Text('Details about incident 1'),
          trailing: DropdownButton<String>(
            items: ['In Progress', 'Resolved', 'Assigned']
                .map((status) => DropdownMenuItem(
                      value: status,
                      child: Text(status),
                    ))
                .toList(),
            onChanged: (value) {
              // Handle status change
            },
            hint: Text('Change Status'),
          ),
        ),
        ListTile(
          title: Text('Incident 2'),
          subtitle: Text('Details about incident 2'),
          trailing: DropdownButton<String>(
            items: ['In Progress', 'Resolved', 'Assigned']
                .map((status) => DropdownMenuItem(
                      value: status,
                      child: Text(status),
                    ))
                .toList(),
            onChanged: (value) {
              // Handle status change
            },
            hint: Text('Change Status'),
          ),
        ),
        // Add more ListTiles for incidents
      ],
    );
  }

  Widget _buildNotifications() {
    return ListView(
      children: [
        ListTile(
          title: Text('New Incident Reported'),
          subtitle: Text('Details about the new incident'),
        ),
        ListTile(
          title: Text('Incident Status Updated'),
          subtitle: Text('Details about the status update'),
        ),
        // Add more ListTiles for notifications
      ],
    );
  }

  Widget _buildAnalytics() {
    return Center(
      child: Text('Analytics & Reporting'),
      // Replace with actual graphs and charts
    );
  }
}
