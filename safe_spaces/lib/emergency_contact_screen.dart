import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'database_helper.dart';
import './models/emergency_contact.dart';
import 'l10n.dart';

class EmergencyContactScreen extends StatefulWidget {
  @override
  _EmergencyContactScreenState createState() => _EmergencyContactScreenState();
}

class _EmergencyContactScreenState extends State<EmergencyContactScreen> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  List<EmergencyContact> _contacts = [];

  final List<EmergencyContact> governmentContacts = [
    EmergencyContact(name: 'Police', number: '100'),
    EmergencyContact(name: 'Fire Brigade', number: '101'),
    EmergencyContact(name: 'Ambulance', number: '102'),
    EmergencyContact(name: 'Disaster Management', number: '108'),
    EmergencyContact(name: 'Women Helpline', number: '1091'),
  ];

  @override
  void initState() {
    super.initState();
    _initializeGovernmentContacts();
    _refreshContacts();
  }

  void _initializeGovernmentContacts() async {
    List<EmergencyContact> existingContacts = await _dbHelper.getContacts();
    for (var contact in governmentContacts) {
      if (!existingContacts
          .any((c) => c.name == contact.name && c.number == contact.number)) {
        await _dbHelper.insertContact(contact);
      }
    }
    _refreshContacts();
  }

  void _refreshContacts() async {
    List<EmergencyContact> contacts = await _dbHelper.getContacts();
    setState(() {
      _contacts = contacts;
    });
  }

  void _addContact() async {
    if (_nameController.text.isNotEmpty && _numberController.text.isNotEmpty) {
      EmergencyContact newContact = EmergencyContact(
        name: _nameController.text,
        number: _numberController.text,
      );
      await _dbHelper.insertContact(newContact);
      _nameController.clear();
      _numberController.clear();
      _refreshContacts();
    }
  }

  void _deleteContact(int id) async {
    await _dbHelper.deleteContact(id);
    _refreshContacts();
  }

  void _callContact(String number) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: number,
    );
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.translate('emergencyContacts')),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: localizations.translate('name'),
                  ),
                ),
                TextField(
                  controller: _numberController,
                  decoration: InputDecoration(
                    labelText: localizations.translate('number'),
                  ),
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _addContact,
                  child: Text(localizations.translate('addContact')),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _contacts.length,
              itemBuilder: (context, index) {
                EmergencyContact contact = _contacts[index];
                return ListTile(
                  title: Text(contact.name),
                  subtitle: Text(contact.number),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.call),
                        onPressed: () => _callContact(contact.number),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deleteContact(contact.id!),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}