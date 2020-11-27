import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:huduma_popote/models/center.dart';
import 'package:huduma_popote/pages/centersubservice.dart';
import 'package:huduma_popote/pages/subservices.dart';
import 'package:huduma_popote/services/services.dart';

class HudumaCenter extends StatefulWidget {
  @override
  _HudumaCenterState createState() => _HudumaCenterState();
}

class _HudumaCenterState extends State<HudumaCenter>
    with AutomaticKeepAliveClientMixin<HudumaCenter> {
  @override
  bool get wantKeepAlive => true;

  List<CenterModel> centers = new List();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        key: PageStorageKey("huduma-centers"),
        child: Column(children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.75,
            child: FutureBuilder(
              future: fetchCenters(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  print(snapshot.data);

                  List<CenterModel> centers = snapshot.data;
                  return Container(
                    child: ListView.builder(
                        itemCount: centers.length,
                        itemBuilder: (ctx, index) {
                          return CenterCard(
                            center: centers[index],
                          );
                        }),
                  );
                }
              },
            ),
          )
        ]),
      ),
    );
  }

  Future fetchCenters() async {
    var res = await PopoteService().getData('/centres');

    List<CenterModel> centerList = new List();

    var body = json.decode(res.body);

    if (!body["success"]) {
      return null;
    } else {
      var centers = body["results"];

      centers.forEach((element) {
        centerList.add(new CenterModel(
            name: element["name"],
            id: element["id"],
            code: element["code"],
            openingTime: element["openingtime"],
            closingTime: element["closingtime"]));
      });

      return centerList;
    }
  }
}

class CenterCard extends StatelessWidget {
  CenterModel center;
  CenterCard({this.center}) {
    center = this.center;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
          return CenterSubServicesPage(
            center: center,
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
            child: Row(
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
                    center.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
