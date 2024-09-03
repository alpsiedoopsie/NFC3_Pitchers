import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import './models/incident.dart'; // Assuming you have an Incident model
import 'l10n.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late Future<List<Incident>> futureIncidents;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    futureIncidents = fetchIncidents();
    _startAutoRefresh();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startAutoRefresh() {
    _timer = Timer.periodic(Duration(seconds: 30), (timer) {
      setState(() {
        futureIncidents = fetchIncidents();
      });
    });
  }

  Future<List<Incident>> fetchIncidents() async {
    final response =
        await http.get(Uri.parse('http://localhost:3000/api/auth/reports'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((incident) => Incident.fromJson(incident))
          .toList();
    } else {
      throw Exception('Failed to load incidents');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset('assets/logo.png', height: 40),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {
                    Navigator.pushNamed(context, '/settings');
                  },
                ),
                IconButton(
                  icon: Icon(Icons.person),
                  onPressed: () {
                    Navigator.pushNamed(context, '/auth');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.blueGrey[50],
              child: FutureBuilder<List<Incident>>(
                future: futureIncidents,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                        child: Text(
                            '${AppLocalizations.of(context).translate('error')}${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                        child: Text(AppLocalizations.of(context)
                            .translate('no_incidents')));
                  } else {
                    List<CircleMarker> circleMarkers =
                        snapshot.data!.map((incident) {
                      return CircleMarker(
                        point: LatLng(incident.latitude, incident.longitude),
                        color: Colors.red.withOpacity(0.6),
                        radius: 20,
                      );
                    }).toList();

                    return FlutterMap(
                      options: MapOptions(
                        initialCenter: LatLng(19.002704080906348,
                            72.81545162083897), // Initial map center
                        initialZoom: 13.0,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                          subdomains: ['a', 'b', 'c'],
                        ),
                        CircleLayer(circles: circleMarkers),
                      ],
                    );
                  }
                },
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: FutureBuilder<List<Incident>>(
              future: futureIncidents,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                      child: Text(
                          '${AppLocalizations.of(context).translate('error')}${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                      child: Text(AppLocalizations.of(context)
                          .translate('no_incidents')));
                } else {
                  return ListView(
                    children: snapshot.data!.map((incident) {
                      return ListTile(
                        title: Text(incident.title),
                        subtitle: Text(incident.description),
                      );
                    }).toList(),
                  );
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.pushNamed(context, '/report');
          if (result == true) {
            // Refresh the data
            setState(() {
              futureIncidents = fetchIncidents();
            });
          }
        },
        child: Icon(Icons.add),
        tooltip: AppLocalizations.of(context).translate('report_incident'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/contacts');
            },
            child: Text(
                AppLocalizations.of(context).translate('emergency_contacts')),
          ),
        ),
      ),
    );
  }
}
