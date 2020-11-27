import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:huduma_popote/models/center.dart';
import 'package:huduma_popote/models/departmentSubService.dart';
import 'package:huduma_popote/models/subservice.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with AutomaticKeepAliveClientMixin<SearchPage> {
  @override
  bool get wantKeepAlive => true;

  bool _loadingResults = false;

  bool _noresults = true;

  String query = "";

  List<CenterModel> centerResults = new List();

  List<DepartmentService> mdaresults = new List();
  // List<CenterModel> centersresults = new List();

  // List(SubService) services = new List();

  List<SubService> services = new List();

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
              child: _noresults
                  ? Center(
                      child: Text(" $query"),
                    )
                  : _loadingResults
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Container(
                          height: MediaQuery.of(context).size.height * 0.75,
                          child: ListView(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24.0),
                                    child: Text(
                                      "Services",
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24.0),
                                    child: Text(
                                      "Huduma Centers",
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24.0),
                                    child: Text(
                                      "Ministries, Departments, Agencies",
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )),
        )
      ],
    );
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
            getSuggestion(value); //start to get suggestion
          },
        ));
  }

  Future<void> getSuggestion(String q) async {
    if (q.length < 1) {
      setState(() {
        _noresults = true;
        // artresults.removeRange(0, artresults.length);
      });
      return null;
    }

    // queryCenters(q);
  }
}
