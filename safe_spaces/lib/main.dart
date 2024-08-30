import 'package:flutter/material.dart';
import 'package:pushy_flutter/pushy_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(title: 'Alert Button'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _initPushy();
  }

  void _initPushy() {
    // Register the device for push notifications
    Pushy.register().then((deviceToken) {
      // Print the device token
      print('Device token: $deviceToken');

      // Save the device token on your backend server (not covered here)
      // You can use the deviceToken to send notifications via your server

      // Listen for incoming notifications
      Pushy.setNotificationListener((data) {
        // Print notification payload data
        print('Received notification: $data');

        // Display an alert with the notification title and message
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(data['title']),
            content: Text(data['message']),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('OK'),
              ),
            ],
          ),
        );
      });
    }).catchError((error) {
      // Handle registration errors
      print('Error registering for Pushy notifications: $error');
    });

    // Request the required notification permissions (only needed for iOS)
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _sendEmergencyNotification() async {
    // Fetch current location
    final position = await _getCurrentPosition();
    if (position != null) {
      final latitude = position.latitude;
      final longitude = position.longitude;

      // Send notification using the Pushy API
      final response = await http.post(
        Uri.parse(
            'https://api.pushy.me/push?api_key=8eba0f039fba33555e210fd07fddf405ec9c1c9a7b266570c72ed2a22b73eb0a'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'to': '/topics/emergency',
          'data': {
            'title': 'Emergency Alert!',
            'message':
                'Help needed at location (Lat: $latitude, Long: $longitude)',
          },
          'notification': {
            'body':
                'Help needed at location (Lat: $latitude, Long: $longitude)',
          },
        }),
      );

      if (response.statusCode == 200) {
        print('Notification sent successfully!');
      } else {
        print('Failed to send notification: ${response.body}');
      }
    } else {
      print('Could not get location');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _sendEmergencyNotification(); // Send the notification when button is pressed
          },
          child: const Text('Send Emergency Alert'),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'SelfHelp',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Submit Incidence',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

Future<bool> _handleLocationPermission() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return false;
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return false;
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return false;
  }

  return true;
}

// This method gets the current location if permission is granted
Future<Position?> _getCurrentPosition() async {
  final hasPermission = await _handleLocationPermission();

  if (!hasPermission) return null;

  return await Geolocator.getCurrentPosition(
    locationSettings: const LocationSettings(
      accuracy: LocationAccuracy.high,
    ),
  );
}
