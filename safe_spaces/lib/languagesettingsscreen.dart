import 'package:flutter/material.dart';

class LanguageSettingsScreen extends StatefulWidget {
  @override
  _LanguageSettingsScreenState createState() => _LanguageSettingsScreenState();
}

class _LanguageSettingsScreenState extends State<LanguageSettingsScreen> {
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Language Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: DropdownButtonFormField<String>(
          value: _selectedLanguage,
          items: ['English', 'Spanish', 'French']
              .map((language) => DropdownMenuItem(
                    value: language,
                    child: Text(language),
                  ))
              .toList(),
          onChanged: (value) {
            setState(() {
              _selectedLanguage = value!;
              // Handle language change
            });
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
