import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../screens/schedule.dart';

class AddNewToDo extends StatefulWidget {
  const AddNewToDo({Key? key}) : super(key: key);

  @override
  State<AddNewToDo> createState() => _AddNewToDoState();
}

class _AddNewToDoState extends State<AddNewToDo> {
  final _formKey = GlobalKey<FormState>();
  DateTime currentDate = DateTime.now();

  TextEditingController title = TextEditingController();
  String selectedDay = "Mondays";
  TextEditingController description = TextEditingController();
  TextEditingController startTime = TextEditingController();
  TextEditingController endTime = TextEditingController();

  final scheduleObj = const Schedule();

  Map<int, String> soliderTime = {
    0: "12",
    12: "12",
    13: "01",
    14: "02",
    15: "03",
    16: "04",
    17: "05",
    18: "06",
    19: "07",
    20: "08",
    21: "09",
    22: "10",
    23: "11",
  };


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF333A47),
        appBar: AppBar(
          elevation: 0,
          title: const Text("Add Todo"),
        ),

        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              TextFormField(
                controller: title,
                style: const TextStyle(color: Colors.white70, fontSize: 18),
                decoration: const InputDecoration(
                    label: Text("What to study?", style: TextStyle(color: Colors.white),),
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
              TextFormField(
                controller: description,
                style: const TextStyle(color: Colors.white70, fontSize: 18),
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: const InputDecoration(
                    label: Text("Description", style: TextStyle(color: Colors.white),),
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
                    backgroundColor: MaterialStatePropertyAll(Colors.redAccent)
                ),
                  onPressed: () async {

                  },
                  child: const Text("Add", style: TextStyle(fontSize: 18),)
              ),
            ],
          ),
        )
    );
  }
}
