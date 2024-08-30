import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'locale_provider.dart';

class LanguageSettingsScreen extends StatefulWidget {
  @override
  _LanguageSettingsScreenState createState() => _LanguageSettingsScreenState();
}

class _LanguageSettingsScreenState extends State<LanguageSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);
    final locale = provider.locale ?? Locale('en');

    return Scaffold(
      appBar: AppBar(
        title: Text('Language Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: DropdownButtonFormField<Locale>(
          value: locale,
          items: [
            Locale('en', ''), // English
            Locale('hi', ''), // Hindi
          ].map((locale) {
            final language = locale.languageCode == 'en' ? 'English' : 'Hindi';
            return DropdownMenuItem(
              value: locale,
              child: Text(language),
            );
          }).toList(),
          onChanged: (Locale? locale) {
            if (locale != null) {
              provider.setLocale(locale);
            }
          },
          decoration: InputDecoration(
            labelText: 'Select Language',
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}
