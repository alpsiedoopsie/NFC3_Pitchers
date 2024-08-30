import 'package:flutter/material.dart';

class NotificationSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SwitchListTile(
              title: Text('Enable Notifications'),
              value: true, // Replace with actual value
              onChanged: (value) {
                // Handle notification toggle
              },
            ),
            SwitchListTile(
              title: Text('Receive Email Notifications'),
              value: false, // Replace with actual value
              onChanged: (value) {
                // Handle email notification toggle
              },
            ),
          ],
        ),
      ),
    );
  }
}
