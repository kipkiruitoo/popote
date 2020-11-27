import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:huduma_popote/models/departmentSubService.dart';
import 'package:huduma_popote/pages/centersubservice.dart';
import 'package:huduma_popote/pages/departmentSubServicesPage.dart';
import 'package:huduma_popote/services/services.dart';

class DepartmentsPage extends StatefulWidget {
  @override
  _DepartmentsPageState createState() => _DepartmentsPageState();
}

class _DepartmentsPageState extends State<DepartmentsPage> with AutomaticKeepAliveClientMixin<DepartmentsPage> {


  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: PageStorageKey("departments"),
      height: MediaQuery.of(context).size.height * 0.7,
      child: FutureBuilder(
        future: fetchMDas(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List<DepartmentService> mdas = snapshot.data;

            // print(object)
            return Container(
              child: ListView.builder(
                  itemCount: mdas.length,
                  itemBuilder: (ctx, index) {
                    print(mdas[index].name);
                    return MdaCard(
                      department: mdas[index],
                    );
                  }),
            );
          }
        },
      ),
    );
  }

  Future fetchMDas() async {
    var res = await PopoteService().getData('/mdas');

    List<DepartmentService> centerList = new List();

    var body = json.decode(res.body);

    if (!body["success"]) {
      return null;
    } else {
      var centers = body["results"];

      centers.forEach((element) {
        centerList.add(new DepartmentService(
          name: element["name"],
          id: element["id"],
          code: element["code"],
        ));
      });

      return centerList;
    }
  }
}

class MdaCard extends StatelessWidget {
  final DepartmentService department;
  MdaCard({this.department});

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
                    Flexible(
                                          child: Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          // "Hello",
                          department.name,
                          // overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                // Text(
                //   department.ministry,
                //   textAlign: TextAlign.left,
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
