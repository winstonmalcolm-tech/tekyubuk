import 'package:flutter/material.dart';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tekyuhbook/model/Event.dart';

class RecurringScreen extends StatefulWidget {
  const RecurringScreen({Key? key}) : super(key: key);

  @override
  State<RecurringScreen> createState() => _RecurringScreenState();
}

class _RecurringScreenState extends State<RecurringScreen> {
  final _formKey = GlobalKey<FormState>();
  DateTime currentDate = DateTime.now();

  TextEditingController title = TextEditingController();
  String selectedDay = "Mondays";
  TextEditingController startTime = TextEditingController();
  TextEditingController endTime = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20,40,20,20),
        children: [
          TextFormField(
            controller: title,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              }
              return null;
            },
            style: const TextStyle(color: Colors.white70, fontSize: 18),
            decoration: const InputDecoration(
                label: Text("What's Planned?", style: TextStyle(color: Colors.white),),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70),
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal)
                )

            ),
          ),

          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.fromLTRB(8,0,8,0),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(
                    color: Colors.white70
                )
            ),
            child: DropdownButton<String>(
                value: selectedDay,
                style: const TextStyle(color: Colors.white70, fontSize: 18),
                iconSize: 30,
                dropdownColor: Colors.teal,
                icon: const Icon(Icons.arrow_drop_down, color: Colors.white70),
                items: const [
                  DropdownMenuItem(value: "Sundays", child: Text("Sundays")),
                  DropdownMenuItem(value: "Mondays", child: Text("Mondays")),
                  DropdownMenuItem(value: "Tuesdays", child: Text("Tuesdays")),
                  DropdownMenuItem(value: "Wednesdays", child: Text("Wednesdays")),
                  DropdownMenuItem(value: "Thursdays", child: Text("Thursdays")),
                  DropdownMenuItem(value: "Fridays", child: Text("Fridays")),
                  DropdownMenuItem(value: "Saturdays", child: Text("Saturdays")),

                ],
                onChanged: (day) {
                  setState(() {
                    selectedDay = day!;
                  });
                }
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: startTime,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select a start time';
              }

              return null;
            },
            style: const TextStyle(color: Colors.white70, fontSize: 18),
            readOnly: true,
            onTap: () async {
              TimeOfDay? beginTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now()
              );

              if (beginTime != null) {
                DateTime parsedTime = DateFormat.jm().parse(beginTime.format(context).toString());
                String formattedTime = DateFormat('HH:mm').format(parsedTime);

                setState(() {
                  startTime.text = formattedTime;
                });
              } else {
                return;
              }
            },
            decoration: const InputDecoration(
                label: Text("Start time", style: TextStyle(color: Colors.white),),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70),
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal)
                )

            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: endTime,
            validator: (value) {
              double startTimeTemp = double.parse(startTime.text.split(":")[0]) + double.parse(startTime.text.split(":")[1]) / 60.0;
              double endTimeTemp = double.parse(endTime.text.split(":")[0]) + double.parse(endTime.text.split(":")[1]) / 60.0;

              if (value == null || value.isEmpty) {
                return "Please select a ending time";
              }

              if (endTimeTemp < startTimeTemp) {
                return "Please select a time that is ahead of Start time";
              }

              return null;
            },
            style: const TextStyle(color: Colors.white70, fontSize: 18),
            readOnly: true,
            onTap: () async {
              TimeOfDay? stopTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now()
              );

              if (stopTime != null) {
                DateTime parsedTime = DateFormat.jm().parse(stopTime.format(context).toString());
                String formattedTime = DateFormat('HH:mm').format(parsedTime);

                setState(() {
                  endTime.text = formattedTime;
                });
              } else {
                return;
              }
            },
            decoration: const InputDecoration(
                label: Text("End time", style: TextStyle(color: Colors.white),),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70),
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal)
                )

            ),
          ),

          const SizedBox(height: 20),

          ElevatedButton(
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.teal)
              ),
              onPressed: () {
                var rand = Random();
                int id = rand.nextInt(1000);
                int day = 1;

                if (_formKey.currentState!.validate() == false) {
                  return;
                }

                switch(selectedDay) {
                  case "Sundays": day = 7;
                  break;
                  case "Mondays": day = 1;
                  break;
                  case "Tuesdays": day = 2;
                  break;
                  case "Wednesdays": day = 3;
                  break;
                  case "Thursdays": day = 4;
                  break;
                  case "Fridays": day = 5;
                  break;
                  case "Saturdays": day = 6;
                  break;
                }

                Map studyDetails = {
                  "planned": title.text,
                  "day": day,
                  "startTime": startTime.text,
                  "endTime": endTime.text,
                };

                Provider.of<Event>(context, listen: false).addTime(day,studyDetails);
                _formKey.currentState!.reset();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Session added")));
              },
              child: const Text("Add", style: TextStyle(fontSize: 18),)
          ),
        ],
      ),
    );
  }
}
