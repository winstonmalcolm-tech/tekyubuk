import 'package:flutter/material.dart';
import 'package:intl/intl.dart';



class Activity {
  String planned, startTime, endTime;
  DateTime? date;
  int day;

  Activity({
    required this.planned,
    required this.day,
    required this.startTime,
    required this.endTime,
    required this.date
  });
}

class Event with ChangeNotifier{

  final Map<int, List<Activity>> _events = {
    1: [],
    2: [],
    3: [],
    4: [],
    5: [],
    6: [],
    7: [],
  };


  final Map<DateTime, List<Activity>> _specificEvents = {};


  int eventsCount(int day) => getEventsForSelectedDay(day).length;
  int specificEventCount(DateTime day) => getSpecificEventsForSelect(day).length;

  void addTime(int id, DateTime? date, Activity activity) {
    if (_events.containsKey(id)) {
      _events[id]?.add(activity);
    } else if (_specificEvents.keys.contains(date)) {
      _specificEvents[date]?.add(activity);
    } else {
      _specificEvents[date!] = [activity];
    }

    notifyListeners();
  }

  void removeTask(int index, int day) {
    getEventsForSelectedDay(day).removeAt(index);
    notifyListeners();
  }

  void removeSpecificTask(int index, DateTime day) {
    getSpecificEventsForSelect(day).removeAt(index);
    notifyListeners();
  }

  List<Activity> getEventsForSelectedDay(int day) {
    return _events[day] ?? [];
  }

  List<Activity> getSpecificEventsForSelect(DateTime day) {
    return _specificEvents[DateTime(day.year, day.month, day.day)] ?? [];
  }

  List<Activity> getEvents(DateTime day) {
    if (_specificEvents.containsKey(DateTime(day.year, day.month, day.day))) {
      return _specificEvents[DateTime(day.year, day.month, day.day)]!;
    }
    else if (day.weekday == 1) {
      return _events.values.elementAt(0);
    } else if (day.weekday == 2) {
      return _events.values.elementAt(1);
    } else if (day.weekday == 3) {
      return _events.values.elementAt(2);
    } else if (day.weekday == 4) {
      return _events.values.elementAt(3);
    } else if (day.weekday == 5) {
      return _events.values.elementAt(4);
    } else if (day.weekday == 6) {
      return _events.values.elementAt(5);
    } else if (day.weekday == 7) {
      return _events.values.elementAt(6);
    }

    return [];
  }



}