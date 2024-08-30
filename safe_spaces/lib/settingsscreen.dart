import 'package:flutter/material.dart';
import 'l10n.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.translate('settings')),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(localizations.translate('profileSettings')),
            onTap: () {
              Navigator.pushNamed(context, '/profile-settings');
            },
          ),
          ListTile(
            title: Text(localizations.translate('notificationSettings')),
            onTap: () {
              Navigator.pushNamed(context, '/notification-settings');
            },
          ),
          ListTile(
            title: Text(localizations.translate('languageSettings')),
            onTap: () {
              Navigator.pushNamed(context, '/language-settings');
            },
          ),
          ListTile(
            title: Text(localizations.translate('privacySettings')),
            onTap: () {
              Navigator.pushNamed(context, '/privacy-settings');
            },
          ),
          ListTile(
            title: Text(localizations.translate('helpSupport')),
            onTap: () {
              Navigator.pushNamed(context, '/help-support');
            },
          ),
        ],
      ),
    );
  }
}
