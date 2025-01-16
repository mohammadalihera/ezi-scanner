import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:easy_scanner/app/data/models/event_data.dart';

class CalendarService {
  Future createCalendarEvent(EventData eventData) async {
    final Event event = Event(
      title: eventData.title,
      description: eventData.description,
      location: eventData.location,
      startDate: eventData.startDate,
      endDate: eventData.endDate,
    );

    Add2Calendar.addEvent2Cal(event);
  }
}
