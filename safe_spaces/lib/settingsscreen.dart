import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Profile Settings'),
            onTap: () {
              Navigator.pushNamed(context, '/profile-settings');
            },
          ),
          ListTile(
            title: Text('Notification Settings'),
            onTap: () {
              Navigator.pushNamed(context, '/notification-settings');
            },
          ),
          ListTile(
            title: Text('Language Settings'),
            onTap: () {
              Navigator.pushNamed(context, '/language-settings');
            },
          ),
          ListTile(
            title: const Text('Privacy Settings'),
            onTap: () {
              Navigator.pushNamed(context, '/privacy-settings');
            },
          ),
          ListTile(
            title: const Text('Help & Support'),
            onTap: () {
              Navigator.pushNamed(context, '/help-support');
            },
          ),
        ],
      ),
    );
  }
}