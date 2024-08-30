import 'package:flutter/material.dart';

class HelpAndSupportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help & Support'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('FAQs'),
            onTap: () {
              // Navigate to FAQs screen
            },
          ),
          ListTile(
            title: Text('Contact Support'),
            onTap: () {
              // Navigate to contact support screen
            },
          ),
          ListTile(
            title: Text('App Version Info'),
            onTap: () {
              // Show app version info
            },
          ),
        ],
      ),
    );
  }
}
