class Incident {
  final String title;
  final String description;
  final double latitude;
  final double longitude;

  Incident({
    required this.title,
    required this.description,
    required this.latitude,
    required this.longitude,
  });

  factory Incident.fromJson(Map<String, dynamic> json) {
    List coordinates = json['coordinates']['coordinates'];
    return Incident(
      title: json['typeOfCrime'] ?? 'No title',
      description: json['descriptionOfCrime'] ?? 'No description',
      latitude:
          coordinates[1] ?? 0.0, // Assuming latitude is the second element
      longitude:
          coordinates[0] ?? 0.0, // Assuming longitude is the first element
    );
  }
}
