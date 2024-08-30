import 'package:flutter/material.dart';

class PrivacySettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SwitchListTile(
              title: Text('Report Anonymously'),
              value: true, // Replace with actual value
              onChanged: (value) {
                // Handle anonymity toggle
              },
            ),
            SwitchListTile(
              title: Text('Share Data with Third Parties'),
              value: false, // Replace with actual value
              onChanged: (value) {
                // Handle data sharing toggle
              },
            ),
          ],
        ),
      ),
    );
  }
}
