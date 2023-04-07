import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tekyuhbook/screens/newToDo.dart';
import 'package:tekyuhbook/model/Event.dart';

class Schedule extends StatefulWidget {
  const Schedule({super.key});

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {

  static late DateTime _selectedDate;

  //Events
  static late Map<DateTime, List<Event>> _events;

  static void setEvents(Event event) {
    _events[_selectedDate]?.add(event);
  }

  @override
  void initState() {
    super.initState();
    _events = {};
    _resetSelectedDate();
  }

  List<Event> _getEventsfromDay(DateTime date) {
    return _events[date] ?? [];
  }

  void _resetSelectedDate() {
    _selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFF333A47),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Schedule',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Colors.tealAccent[100]),
              ),
            ),
            TableCalendar(
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2100, 3, 14),
              focusedDay: _selectedDate,
              onDaySelected: (day, day2) {
                setState(() {
                  _selectedDate = day;
                });
              },
              rowHeight: 50,
              calendarFormat: CalendarFormat.twoWeeks,
              eventLoader: _getEventsfromDay,
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleTextStyle: TextStyle(color: Colors.redAccent[100], fontSize: 18),
                leftChevronIcon: const Icon(Icons.chevron_left, color: Colors.white,),
                rightChevronIcon: const Icon(Icons.chevron_right, color: Colors.white,)
              ),
              daysOfWeekStyle: const DaysOfWeekStyle(
                weekdayStyle: TextStyle(color: Colors.white),
                weekendStyle: TextStyle(color: Colors.tealAccent),
              ),
              calendarStyle: const CalendarStyle(
                canMarkersOverflow: true,
                defaultTextStyle: TextStyle(color:Colors.white),
                markerDecoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blueAccent
                ),
                todayDecoration: BoxDecoration(
                  color: Colors.teal,
                  shape: BoxShape.circle
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.redAccent,
                  shape: BoxShape.circle
                )
              ),
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDate, day);
              },
            ),

            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.teal[200]),
                ),
                child: const Text(
                  'RESET',
                  style: TextStyle(color: Color(0xFF333A47)),
                ),
                onPressed: () => setState(() => _resetSelectedDate()),
              ),
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                'All Planned Dates',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent[100],
        child: const Icon(Icons.add),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => const AddNewToDo()));
      },
      ),
    );
  }
}


/*

CalendarTimeline(
              showYears: true,
              initialDate: _selectedDate,
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 365 * 100)),
              onDateSelected: (date) => setState(() => _selectedDate = date),
              leftMargin: 20,
              monthColor: Colors.white70,
              dayColor: Colors.teal[200],
              dayNameColor: const Color(0xFF333A47),
              activeDayColor: Colors.white,
              activeBackgroundDayColor: Colors.redAccent[100],
              dotsColor: const Color(0xFF333A47),
              selectableDayPredicate: (date) => date.day != 23,
              locale: 'en',
            ),
 */