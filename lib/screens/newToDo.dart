import 'package:flutter/material.dart';
import '../screens/recurringTabScreen.dart';
import '../screens/singleTabScreen.dart';


class AddNewToDo extends StatefulWidget {
  const AddNewToDo({Key? key}) : super(key: key);

  @override
  State<AddNewToDo> createState() => _AddNewToDoState();
}

class _AddNewToDoState extends State<AddNewToDo> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
        backgroundColor: const Color(0xFF333A47),
        appBar: AppBar(
          elevation: 0,
          title: const Text("Add Todo"),
          bottom: const TabBar(
            indicatorColor: Colors.tealAccent,
            labelColor: Colors.tealAccent,
            unselectedLabelColor: Colors.white54,
            tabs: [
              Tab(
                child: Text("Recurring"),
              ),
              Tab(
                child: Text("Single"),
              )
            ]
          ),
        ),

        body: const TabBarView(children: [
          RecurringScreen(),
          SingleTabScreen(),
        ])
      ),
    );
  }
}
