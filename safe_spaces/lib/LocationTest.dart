import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

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

Future<Position?> _getCurrentPosition() async {
  final hasPermission = await _handleLocationPermission();

  if (!hasPermission) return null;

  return await Geolocator.getCurrentPosition(
    locationSettings: const LocationSettings(
      accuracy: LocationAccuracy.high,
    ),
  );
}

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String _location = "Fetching location...";

  @override
  void initState() {
    super.initState();
    _fetchLocation();
  }

  void _fetchLocation() async {
    Position? position = await _getCurrentPosition();
    if (position != null) {
      setState(() {
        _location =
            "Latitude: ${position.latitude}, Longitude: ${position.longitude} ,time : ${position.timestamp}";
      });
    } else {
      setState(() {
        _location = "Could not get location";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Example'),
      ),
      body: Center(
        child: Text(_location),
      ),
    );
  }
}
