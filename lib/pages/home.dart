
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
  @override
  Widget build(BuildContext context) {
        return Scaffold(
          body: PageView(
            children: [
              ServicesPage(),
              AppointmentsPage(),
              ProfilePage()
            ],
          ),
          bottomNavigationBar: CupertinoTabBar(
              items: [
            BottomNavigationBarItem(icon: Icon(Icons.home)),
            BottomNavigationBarItem(icon: Icon(Icons.favorite)),
            BottomNavigationBarItem(icon: Icon(Icons.person))
          ],
            activeColor: Color(0xFFB40284A),
            inactiveColor: Color(0xFFB40284A).withOpacity(0.6),
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
    pageController.jumpToPage(
      value,
    );
  }
}

