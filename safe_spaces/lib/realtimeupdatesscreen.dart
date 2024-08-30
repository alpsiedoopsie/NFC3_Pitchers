import 'package:flutter/material.dart';

class RealTimeUpdatesScreen extends StatelessWidget {
  final List<Map<String, String>> updates = [
    {
      'title': 'Incident 1',
      'timestamp': '2023-10-01 12:00',
      'description': 'Description of incident 1',
      'status': 'In Progress',
    },
    {
      'title': 'Incident 2',
      'timestamp': '2023-10-02 14:30',
      'description': 'Description of incident 2',
      'status': 'Resolved',
    },
    // Add more updates as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Real-Time Updates'),
      ),
      body: ListView.builder(
        itemCount: updates.length,
        itemBuilder: (context, index) {
          final update = updates[index];
          return ListTile(
            title: Text(update['title']!),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(update['timestamp']!),
                Text(update['description']!),
              ],
            ),
            trailing: Text(
              update['status']!,
              style: TextStyle(
                color: update['status'] == 'Resolved'
                    ? Colors.green
                    : Colors.orange,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
      ),
    );
  }
}
