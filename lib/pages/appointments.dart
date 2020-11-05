import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class AppointmentsPage extends StatefulWidget {
  @override
  _AppointmentsPageState createState() => _AppointmentsPageState();
}

class _AppointmentsPageState extends State<AppointmentsPage>
    with SingleTickerProviderStateMixin {
  CalendarController _calendarController = new CalendarController();

  TabController _appointmentsTabController;

  @override
  void initState() {
    super.initState();
    _appointmentsTabController = new TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      margin: EdgeInsets.only(top: 30),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                height: MediaQuery.of(context).size.height * 0.45,
                padding: EdgeInsets.all(8.0),
                child: TableCalendar(calendarController: _calendarController)),
            Container(
              height: MediaQuery.of(context).size.height * 0.55,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: TabBar(
                      indicatorColor: Colors.red,
                      tabs: [
                        Text("Upcoming",
                            style: TextStyle(
                              color: Colors.black,
                            )),
                        Text("Recent",
                            style: TextStyle(
                              color: Colors.black,
                            )),
                        Text("Done",
                            style: TextStyle(
                              color: Colors.black,
                            ))
                      ],
                      controller: _appointmentsTabController,
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: TabBarView(
                        controller: _appointmentsTabController,
                        children: [
                          Center(child: Text("Upcoming Appointments")),
                          Center(child: Text("Recent Appointments")),
                          Center(child: Text("Done Appointments")),
                        ]),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
