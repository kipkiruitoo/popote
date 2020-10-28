
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huduma_popote/pages/appointments.dart';
import 'package:huduma_popote/pages/profile.dart';
import 'package:huduma_popote/pages/services.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController pageController;

  int getPageIndex = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }


  var _pages = [
    ServicesPage(),
    AppointmentsPage(),
    ProfilePage()
  ];



  @override
  Widget build(BuildContext context) {
        return Scaffold(
          body: IndexedStack(
            index: getPageIndex,
            children: _pages,
          ),
          bottomNavigationBar: CupertinoTabBar(
              items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Services")),
            BottomNavigationBarItem(icon: Icon(Icons.calendar_today), title: Text("Appointments")),
            BottomNavigationBarItem(icon: Icon(Icons.person), title: Text("Profile"))
          ],
            activeColor: Colors.black,
            inactiveColor: Colors.black.withOpacity(0.6),
            backgroundColor: Colors.white,
            currentIndex: getPageIndex,
            onTap: changePage,
          ),

        );
  }

  void whenPageChanges(int page) {
    setState(() {
      getPageIndex = page;
    });
  }

  void changePage(int value) {

    setState(() {
      getPageIndex = value;
    });

  }
}

