import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:huduma_popote/models/departmentSubService.dart';
import 'package:huduma_popote/pages/centersubservice.dart';
import 'package:huduma_popote/pages/departmentSubServicesPage.dart';

class DepartmentsPage extends StatefulWidget {
  @override
  _DepartmentsPageState createState() => _DepartmentsPageState();
}

class _DepartmentsPageState extends State<DepartmentsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      child: FutureBuilder(
        future: DefaultAssetBundle.of(context)
            .loadString('assets/data/departments.json'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List<DepartmentService> services =
                parseJosn(snapshot.data.toString());
            return Container(
              child: ListView.builder(
                  itemCount: services.length,
                  itemBuilder: (ctx, index) {
                    return CenterCard(
                      department: services[index],
                    );
                  }),
            );
          }
        },
      ),
    );
  }

  List<DepartmentService> parseJosn(String response) {
    if (response == null) {
      return [];
    }
    final parsed =
        json.decode(response.toString()).cast<Map<String, dynamic>>();
    return parsed
        .map<DepartmentService>((json) => new DepartmentService.fromJson(json))
        .toList();
  }
}

class CenterCard extends StatelessWidget {
  DepartmentService department;
  CenterCard({this.department}) {
    department = this.department;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
          return DepartmentSubServicesPage(
            department: department,
          );
        }));
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
        // height: 100,
        // width: 150,
        child: Card(
          elevation: 4,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset(
                      "assets/images/logo.png",
                      width: 65,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        // "Hello",
                        department.name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  department.ministry,
                  textAlign: TextAlign.left,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
