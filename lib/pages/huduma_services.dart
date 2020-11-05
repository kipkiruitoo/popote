import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:huduma_popote/models/center.dart';
import 'package:huduma_popote/pages/centersubservice.dart';
import 'package:huduma_popote/pages/subservices.dart';

class HudumaCenter extends StatefulWidget {
  @override
  _HudumaCenterState createState() => _HudumaCenterState();
}

class _HudumaCenterState extends State<HudumaCenter> {
  TextEditingController editingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        child: Column(children: [
          // Padding(
          //   padding: const EdgeInsets.all(10.0),
          //   child: TextField(
          //     controller: editingController,
          //     onChanged: (value) {
          //       filterSearchResults(value);
          //     },
          //     decoration: InputDecoration(
          //         labelText: "Search",
          //         hintText: "Search",
          //         labelStyle: TextStyle(color: Colors.red),
          //         prefixIcon: Icon(Feather.search),
          //         focusColor: Colors.red,
          //         enabledBorder: const OutlineInputBorder(
          //           // width: 0.0 produces a thin "hairline" border
          //           borderSide:
          //               const BorderSide(color: Colors.grey, width: 0.0),
          //         ),
          //         focusedBorder: const OutlineInputBorder(
          //           // width: 0.0 produces a thin "hairline" border
          //           borderSide: const BorderSide(color: Colors.red, width: 0.7),
          //         ),
          //         border: OutlineInputBorder(
          //             borderRadius: BorderRadius.all(Radius.circular(10.0)))),
          //   ),
          // ),
          Container(
            height: MediaQuery.of(context).size.height * 0.7,
            child: FutureBuilder(
              future: DefaultAssetBundle.of(context)
                  .loadString('assets/data/centers.json'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  List<CenterModel> services =
                      parseJosn(snapshot.data.toString());
                  return Container(
                    child: ListView.builder(
                        itemCount: services.length,
                        itemBuilder: (ctx, index) {
                          return CenterCard(
                            center: services[index],
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

  void filterSearchResults(String value) {}

  List<CenterModel> parseJosn(String response) {
    if (response == null) {
      return [];
    }
    final parsed =
        json.decode(response.toString()).cast<Map<String, dynamic>>();
    return parsed
        .map<CenterModel>((json) => new CenterModel.fromJson(json))
        .toList();
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
