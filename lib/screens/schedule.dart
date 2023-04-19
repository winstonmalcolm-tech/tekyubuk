import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tekyuhbook/screens/newToDo.dart';
import 'package:tekyuhbook/model/Event.dart';
import 'package:intl/intl.dart';


class Schedule extends StatefulWidget {
  const Schedule({super.key});

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {

  DateTime _selectedDate = DateTime.now();
  Event eventObj = Event();
  String _datesTitle = DateFormat.yMMMd().format(DateTime.now());
  List<Map> _todos = [];

  @override
  void initState() {
    super.initState();
    _resetSelectedDate();
  }


  void _resetSelectedDate() {
    _selectedDate = DateTime.now();
    _datesTitle = DateFormat.yMMMd().format(DateTime.now());
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
              eventLoader: context.watch<Event>().getEvents,

              onDaySelected: (day, day2) {
                setState(() {
                  _selectedDate = day;
                  _datesTitle = DateFormat.yMMMd().format(day);
                });
              },
              rowHeight: 50,
              calendarFormat: CalendarFormat.twoWeeks,
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle: TextStyle(color: Colors.tealAccent, fontSize: 18),
                leftChevronIcon: Icon(Icons.chevron_left, color: Colors.white,),
                rightChevronIcon: Icon(Icons.chevron_right, color: Colors.white,)
              ),
              daysOfWeekStyle: const DaysOfWeekStyle(
                weekdayStyle: TextStyle(color: Colors.white),
                weekendStyle: TextStyle(color: Colors.tealAccent),
              ),
              calendarStyle: const CalendarStyle(
                canMarkersOverflow: false,
                defaultTextStyle: TextStyle(color:Colors.white),
                markersAlignment: Alignment.bottomCenter,
                markerDecoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.tealAccent
                ),
                todayDecoration: BoxDecoration(
                  color: Colors.teal,
                  shape: BoxShape.circle
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.green,
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
            Center(
              child: Text(
                _datesTitle,
                style: const TextStyle(color: Colors.greenAccent, fontSize: 20),
              ),
            ),
            const SizedBox(height: 20),
            (Provider.of<Event>(context, listen: true).getEventsForSelectedDay(_selectedDate.weekday).isEmpty && Provider.of<Event>(context, listen: true).getSpecificEventsForSelect(_selectedDate).isEmpty) ? const Center(child: Text("Nothing planned for this day", style: TextStyle(color: Colors.white, fontSize: 18, fontStyle: FontStyle.italic),),): Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 10),
                  child: Column(
                    children: [
                      for (int index=0; index<Provider.of<Event>(context, listen: true).eventsCount(_selectedDate.weekday); index++) ... [
                          FractionallySizedBox(
                                  child:  Dismissible(
                                    key: UniqueKey(),
                                    onDismissed: (direction) {
                                      setState(() {
                                        Provider.of<Event>(context, listen: false).removeTask(index, _selectedDate.weekday);
                                      });
                                    },
                                    background: Container(
                                      margin: const EdgeInsets.only(bottom: 20),
                                      padding: const EdgeInsets.only(left: 10),
                                      alignment: Alignment.centerLeft,
                                      height: 90,
                                      child: const Icon(Icons.delete_sweep_outlined, color: Colors.white, size: 30,),
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      margin: const EdgeInsets.only(bottom: 20),
                                      decoration: const BoxDecoration(
                                        color: Colors.teal,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10)
                                        ),
                                      ),
                                      height: 120,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(Provider.of<Event>(context, listen: false).getEventsForSelectedDay(_selectedDate.weekday)[index].planned, style: const TextStyle(color: Colors.white, fontSize: 20, fontStyle: FontStyle.italic),),
                                          const SizedBox(height: 15),
                                          (Provider.of<Event>(context, listen: false).getEventsForSelectedDay(_selectedDate.weekday)[index].date == null) ?
                                            Text("From ${Provider.of<Event>(context, listen: false).getEventsForSelectedDay(_selectedDate.weekday)[index].startTime} to ${Provider.of<Event>(context, listen: false).getEventsForSelectedDay(_selectedDate.weekday)[index].endTime}", style: const TextStyle(color: Colors.white, fontSize: 17)) :
                                              Text("On ${Provider.of<Event>(context, listen: false).getEventsForSelectedDay(_selectedDate.weekday)[index].date} at ${context.read<Event>().getEventsForSelectedDay(_selectedDate.weekday)[index].startTime}",style: const TextStyle(color: Colors.white, fontSize: 17)),
                                          const SizedBox(height: 5),
    
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: const [
                                              Text("Swipe to remove", style: TextStyle(color: Colors.white, fontSize: 15, fontStyle: FontStyle.italic))
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                              )
                          ),
                        ],

                      for (int index=0; index<Provider.of<Event>(context, listen: true).specificEventCount(_selectedDate); index++) ... [
                        FractionallySizedBox(
                            child:  Dismissible(
                              key: UniqueKey(),
                              onDismissed: (direction) {
                                setState(() {
                                  //Provider.of<Event>(context, listen: false).removeTask(index, _selectedDate.weekday);
                                  Provider.of<Event>(context, listen: false).removeSpecificTask(index, _selectedDate);
                                });
                              },
                              background: Container(
                                margin: const EdgeInsets.only(bottom: 20),
                                padding: const EdgeInsets.only(left: 10),
                                alignment: Alignment.centerLeft,
                                height: 90,
                                child: const Icon(Icons.delete_sweep_outlined, color: Colors.white, size: 30,),
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.only(bottom: 20),
                                decoration: const BoxDecoration(
                                  color: Colors.teal,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10)
                                  ),
                                ),
                                height: 120,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(Provider.of<Event>(context, listen: false).getSpecificEventsForSelect(_selectedDate)[index].planned, style: const TextStyle(color: Colors.white, fontSize: 20, fontStyle: FontStyle.italic),),
                                    const SizedBox(height: 15),
                                    Text("On ${DateFormat.yMMMd().format(Provider.of<Event>(context, listen: false).getSpecificEventsForSelect(_selectedDate)[index].date!)} at ${context.read<Event>().getSpecificEventsForSelect(_selectedDate)[index].startTime}",style: const TextStyle(color: Colors.white, fontSize: 17)),
                                    const SizedBox(height: 5),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: const [
                                        Text("Swipe to remove", style: TextStyle(color: Colors.white, fontSize: 15, fontStyle: FontStyle.italic))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                        ),
                      ],
                    ]
                  ),
                ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal[400],
        child: const Icon(Icons.add),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => const AddNewToDo()));
      },
      ),
    );
  }
}