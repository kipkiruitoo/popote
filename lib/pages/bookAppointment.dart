import 'package:flutter/material.dart';
import 'package:huduma_popote/models/center.dart';
import 'package:huduma_popote/models/subservice.dart';
import 'package:intl/intl.dart';

class BookAppointment extends StatefulWidget {
  SubService service;
  CenterModel center;

  BookAppointment({this.service, this.center});
  @override
  _BookAppointmentState createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  DateTime selectedDate = DateTime.now();

  // time picker slots

  @override
  Widget build(BuildContext context) {
    final startTime = TimeOfDay(hour: 8, minute: 0);
    final endTime = TimeOfDay(hour: 17, minute: 00);
    final step = Duration(minutes: 60);

    final times = getTimes(startTime, endTime, step)
        .map((tod) => tod.format(context))
        .toList();

    // print(times);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Book appointment at ${widget.center.name}",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Select Date of Appointment"),
                  ),
                  RaisedButton(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () => _selectDate(context),
                    color: Colors.green,
                    child: Text(
                      "Select Date",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          letterSpacing: 2.2),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(DateFormat("MMMM d y").format(selectedDate)),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(
                    color: Colors.green,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Available TimeSlots"),
                  ),
                  Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: Wrap(
                        children: [
                          for (var time in times)
                            Container(
                              width: 100,
                              margin: const EdgeInsets.all(10.0),
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.green),
                                borderRadius: BorderRadius.all(Radius.circular(
                                        10.0) //         <--- border radius here
                                    ),
                              ), //       <--- BoxDecoration here
                              child: Text(
                                time,
                                style: TextStyle(fontSize: 30.0),
                              ),
                            ),
                        ],
                      )),
                  Divider(
                    color: Colors.green,
                  ),
                  Text(widget.service.title),
                  SizedBox(
                    height: 15,
                  ),
                  RaisedButton(
                    color: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () {},
                    child: Text(
                      "Book Appointment",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          letterSpacing: 2.2),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  bool _decideWhichDayToEnable(DateTime day) {
    if ((day.isAfter(DateTime.now().subtract(Duration(days: 1))) &&
        day.isBefore(DateTime.now().add(Duration(days: 15))))) {
      return true;
    }
    return false;
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
      helpText: 'Select Appointment date',
      selectableDayPredicate: _decideWhichDayToEnable,
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  Iterable<TimeOfDay> getTimes(
      TimeOfDay startTime, TimeOfDay endTime, Duration step) sync* {
    var hour = startTime.hour;
    var minute = startTime.minute;

    do {
      yield TimeOfDay(hour: hour, minute: minute);
      minute += step.inMinutes;
      while (minute >= 60) {
        minute -= 60;
        hour++;
      }
    } while (hour < endTime.hour ||
        (hour == endTime.hour && minute <= endTime.minute));
  }
}
