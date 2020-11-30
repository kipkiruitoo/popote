import 'dart:convert';
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:huduma_popote/models/center.dart';
import 'package:huduma_popote/models/departmentSubService.dart';
import 'package:huduma_popote/models/subservice.dart';
import 'package:huduma_popote/pages/departmentSubServicesPage.dart';
import 'package:huduma_popote/services/services.dart';
import 'package:random_color/random_color.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with AutomaticKeepAliveClientMixin<SearchPage> {
  @override
  bool get wantKeepAlive => true;

  bool fetchingServices = false;

  bool fetchingMdas = false;

  bool _noServices = true;

  bool _noMdas = true;

  String query = "";

  List<CenterModel> centerResults = new List();

  List<DepartmentService> mdaresults = new List();
  // List<CenterModel> centersresults = new List();

  // List(SubService) services = new List();

  List<SubService> subservices = new List();

  // String query;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          leading: Image.asset("assets/images/logo.png"),
          title: Text(
            "Huduma Online",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          bottom: PreferredSize(
              preferredSize: Size.fromHeight(55), child: searchField()),
        ),
        SliverToBoxAdapter(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 8.0),
                  child: Text("Ministries, Departments and Agencies",
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold)),
                ),
                _noMdas
                    ? Center(
                        child: Text("Start Typing to Search for an MDA"),
                      )
                    : fetchingMdas
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Container(
                            height: 200,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12.0, horizontal: 16.0),
                                itemCount: mdaresults.length,
                                itemBuilder: (ctx, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          new MaterialPageRoute(builder: (ctx) {
                                        return DepartmentSubServicesPage(
                                          department: mdaresults[index],
                                        );
                                      }));
                                    },
                                    child: Container(
                                      // color: randomOpaqueColor(),
                                      decoration: BoxDecoration(
                                        color: randomOpaqueColor(),
                                        borderRadius:
                                            new BorderRadius.circular(16.0),
                                      ),
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 8.0),
                                      height: 200,
                                      width: 130.0,
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.fromLTRB(
                                                5, 60, 5, 10),
                                            child: Text(
                                              mdaresults[index].name,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          )
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 8.0),
                  child: Text(
                    "Services",
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                _noServices
                    ? Center(
                        child: Text("Start Typing to Search for a Service"),
                      )
                    : fetchingServices
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Container(
                            height: MediaQuery.of(context).size.height * 0.62,
                            child: ListView.builder(
                                // scrollDirection: Axis.horizontal,
                                itemCount: subservices.length,
                                itemBuilder: (ctx, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ExpansionTile(
                                      leading: Image.asset(
                                        "assets/images/logo.png",
                                        width: 65,
                                      ),
                                      title: Text(
                                        subservices[index].title != null
                                            ? subservices[index].title
                                            : 'N/A',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Text(
                                          "Offered By: ${subservices[index].mdaname != null ? subservices[index].mdaname : 'N/A'} "),
                                      children: [
                                        Html(
                                            data:
                                                subservices[index].description)
                                      ],
                                      // subtitle: Text(service.mdaname),
                                    ),
                                  );
                                }),
                          )
              ],
            ),
          ),
        )
      ],
    );
  }

  static Color randomOpaqueColor() {
    RandomColor _randomColor = RandomColor();
    return _randomColor.randomColor(
        colorSaturation: ColorSaturation.highSaturation,
        colorHue: ColorHue.blue,
        colorBrightness: ColorBrightness.dark);
    // return Color(Random().nextInt(0xffffffff));
  }

  Widget searchField() {
    return AnimatedContainer(
        duration: Duration(milliseconds: 1500),
        child: TextField(
          autofocus: false,
          style: TextStyle(color: Color(0xFFB40284A), fontSize: 18),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Feather.search,
              color: Colors.black,
            ),
            hintStyle:
                TextStyle(color: Colors.black.withOpacity(0.8), fontSize: 12),
            hintText: "Search for a Service, Department or Huduma Center",
            // enabledBorder: UnderlineInputBorder(
            //   borderSide: BorderSide(color: Color(0xFFB40284A), width: 1),
            // ), //under line border, set OutlineInputBorder() for all side border
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFB40284A), width: 1),
            ), // focused border color
          ), //decoration for search input field
          onChanged: (value) {
            //update the value of query
            print(value.isEmpty);
            getSuggestion(value); //start to get suggestion
          },
        ));
  }

  Future<void> getSuggestion(String q) async {
    setState(() {
      fetchingMdas = true;
      fetchingServices = true;

      subservices = new List();
      mdaresults = new List();
    });
    if (q.isEmpty) {
      setState(() {
        _noServices = true;
        _noMdas = true;
        fetchingMdas = false;
        fetchingServices = false;
        subservices = new List();
        // artresults.removeRange(0, artresults.length);
      });
      return null;
    }

    await Future.wait([searchMDa(q), searchServices(q)]);
  }

  Future<void> searchMDa(String q) async {
    setState(() {
      mdaresults = [];
    });
    // fetch mdas
    var mdares = await PopoteService().getData('/search/mda?q=${q}');
    var mdabody = json.decode(mdares.body);

    // print(body);

    if (mdabody["success"]) {
      var serviceList = mdabody["results"];
      serviceList.forEach((element) {
        // print(element["servicename"]);
        DepartmentService service = new DepartmentService(
            name: element["name"], id: element["id"], code: element["code"]);

        setState(() {
          mdaresults.add(service);
        });
      });

      setState(() {
        _noMdas = false;
        fetchingMdas = false;
      });
    }
  }

  Future<void> searchServices(String q) async {
    // fetch services

    var res = await PopoteService().getData('/search/services?q=${q}');
    var body = json.decode(res.body);

    // print(body);

    if (body["success"]) {
      var serviceList = body["results"];
      serviceList.forEach((element) {
        print(element["servicename"]);
        SubService service = new SubService(
            title: element["name"],
            mdaId: element["mdaid"],
            mdaname: element["mdaname"],
            description: element["details"]);

        setState(() {
          subservices.add(service);
        });
      });

      setState(() {
        _noServices = false;
        fetchingServices = false;
      });
    }
  }
}
