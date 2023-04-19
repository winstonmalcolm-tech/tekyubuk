import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../model/Event.dart';

class SingleTabScreen extends StatefulWidget {
  const SingleTabScreen({Key? key}) : super(key: key);

  @override
  State<SingleTabScreen> createState() => _SingleTabScreenState();
}

class _SingleTabScreenState extends State<SingleTabScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController time = TextEditingController();
  DateTime? actualDate;


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
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

          TextFormField(
            controller: date,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select a date';
              }
              return null;
            },
            style: const TextStyle(color: Colors.white70, fontSize: 18),
            readOnly: true,
            onTap: () async {
              DateTime? setDate = await showDatePicker(
                  context: context,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.utc(2100, 3, 14),
                  initialDate: DateTime.now().add(const Duration(days: 1)),
              );

              if (setDate != null) {

                setState(() {
                  date.text = DateFormat.yMMMd().format(setDate);
                  actualDate = setDate;
                });
              } else {
                return;
              }
            },
            decoration: const InputDecoration(
                label: Text("Date", style: TextStyle(color: Colors.white),),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal)
                )

            ),
          ),
          const SizedBox(height: 20),

          TextFormField(
            controller: time,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select a time';
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
                  time.text = formattedTime;
                });
              } else {
                return;
              }
            },
            decoration: const InputDecoration(
                label: Text("Time", style: TextStyle(color: Colors.white),),
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
                if (_formKey.currentState!.validate() == false) {
                  return;
                }



                Provider.of<Event>(context, listen: false).addTime(0, DateTime(actualDate!.year, actualDate!.month, actualDate!.day), Activity(planned: title.text, day: 8, startTime: time.text, endTime: "", date: DateTime(actualDate!.year, actualDate!.month, actualDate!.day)));

                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Event added")));
              },
              child: const Text("Add", style: TextStyle(fontSize: 18),)
          ),

        ],
      ),
    );
  }
}
