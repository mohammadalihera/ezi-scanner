class EventData {
  final String title;
  final DateTime startDate;
  final DateTime endDate;
  final String description;
  final String location;

  EventData({
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.description,
    required this.location,
  });

  @override
  String toString() {
    return 'EventData(title: $title, startDate: $startDate, endDate: $endDate, description: $description, location: $location)';
  }

  static EventData parseEvent(String eventString) {
    final lines =
        eventString.split('\n').where((line) => line.isNotEmpty).toList();

    String? title;
    DateTime? startDate;
    DateTime? endDate;
    String? location;
    String? description;

    for (var line in lines) {
      if (line.startsWith('SUMMARY:')) {
        title = line.substring(8);
      } else if (line.startsWith('DTSTART:')) {
        startDate = DateTime.parse(line.substring(8));
      } else if (line.startsWith('DTEND:')) {
        endDate = DateTime.parse(line.substring(6));
      } else if (line.startsWith('LOCATION:')) {
        location = line.substring(9);
      } else if (line.startsWith('DESCRIPTION:')) {
        description = line.substring(12);
      }
    }

    if (title == null ||
        startDate == null ||
        endDate == null ||
        location == null ||
        description == null) {
      throw Exception('Invalid event data');
    }

    return EventData(
      title: title,
      startDate: startDate,
      endDate: endDate,
      location: location,
      description: description,
    );
  }
}
