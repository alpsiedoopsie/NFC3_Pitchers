import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'l10n.dart';

class IncidentReportingScreen extends StatefulWidget {
  @override
  _IncidentReportingScreenState createState() =>
      _IncidentReportingScreenState();
}

class _IncidentReportingScreenState extends State<IncidentReportingScreen> {
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String _selectedIncidentType = 'Theft';
  bool _isAnonymous = false;

  Future<void> _submitReport() async {
    bool isOnline = true; // Replace with actual network check

    if (isOnline) {
      try {
        List<Location> locations =
            await locationFromAddress(_locationController.text);
        Location location = locations.first;

        final response = await http.post(
          Uri.parse(
              'http://localhost:3000/api/auth/submit'), // Replace with your backend API URL
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            'location': _locationController.text,
            'coordinates': {
              'type': 'Point',
              'coordinates': [location.longitude, location.latitude],
            },
            'typeOfCrime': _selectedIncidentType,
            'descriptionOfCrime': _descriptionController.text,
          }),
        );

        if (response.statusCode == 201) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Report submitted successfully!')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to submit report.')),
          );
          print(response.body);
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
        print(e);
      }
    }
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.translate('title')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            DropdownButtonFormField<String>(
              value: _selectedIncidentType,
              items: [
                'Theft',
                'Vandalism',
                'Assault',
                'Ragging',
                'Harassment',
                'Domestic Violence',
                'Burglary',
                'Cybercrime',
                'Fraud',
                'Drug Abuse',
                'Arson',
                'Kidnapping',
                'Trespassing',
                'Sexual Assault',
                'Hate Crime',
                'Stalking',
                'Road Rage',
                'Public Disturbance',
                'Animal Abuse',
                'Human Trafficking',
                'Gang Activity',
                'Child Abuse'
              ]
                  .map((type) => DropdownMenuItem(
                        value: type,
                        child: Text(type),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedIncidentType = value!;
                });
              },
              decoration: InputDecoration(
                labelText: localizations.translate('incidentType'),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _locationController,
              decoration: InputDecoration(
                labelText: localizations.translate('location'),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: localizations.translate('description'),
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
            SizedBox(height: 16),
            // SwitchListTile(
            //   title: Text(localizations.translate('reportAnonymously')),
            //   value: _isAnonymous,
            //   onChanged: (value) {
            //     setState(() {
            //       _isAnonymous = value;
            //     });
            //   },
            // ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _submitReport,
              child: Text(localizations.translate('submitReport')),
            ),
          ],
        ),
      ),
    );
  }
}
