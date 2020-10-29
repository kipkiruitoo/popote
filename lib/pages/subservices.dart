import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:huduma_popote/models/service.dart';
import 'package:huduma_popote/models/subservice.dart';

class SubServicePage extends StatefulWidget {
  Service service;

  SubServicePage({this.service});
  @override
  _SubServicePageState createState() => _SubServicePageState();
}

class _SubServicePageState extends State<SubServicePage> {
  // full list of subservices
  List<SubService> subservices;

  // list of subservices to show
  List<SubService> searchedsubservices = List<SubService>();

  TextEditingController editingController = new TextEditingController();

  @override
  void initState() {
    subservices = widget.service.services;
    searchedsubservices.addAll(subservices);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.service.name,
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.9,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      controller: editingController,
                      onChanged: (value) {
                        filterSearchResults(value);
                      },
                      decoration: InputDecoration(
                          labelText: "Search",
                          hintText: "Search",
                          labelStyle: TextStyle(color: Colors.red),
                          prefixIcon: Icon(Feather.search),
                          focusColor: Colors.red,
                          enabledBorder: const OutlineInputBorder(
                            // width: 0.0 produces a thin "hairline" border
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 0.0),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            // width: 0.0 produces a thin "hairline" border
                            borderSide:
                                const BorderSide(color: Colors.red, width: 0.7),
                          ),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)))),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: ListView.builder(
                        itemCount: searchedsubservices.length,
                        itemBuilder: (ctx, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ExpansionTile(
                              title:
                                  Html(data: searchedsubservices[index].title),
                              leading: Image.asset(
                                "assets/images/${widget.service.image}",
                                width: 65,
                              ),
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "Description",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Html(
                                      data: searchedsubservices[index]
                                          .description),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Cost",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.start,
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Html(
                                          data:
                                              searchedsubservices[index].cost),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "TimeLines",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.start,
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Html(
                                          data: searchedsubservices[index]
                                              .timelines),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Contact",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.left,
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Html(
                                          data: searchedsubservices[index]
                                              .contact)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void filterSearchResults(String query) {
    print("this are the total number of subservices ${subservices.length}");
    print(subservices.toString());
    List<SubService> dummySearchList = List<SubService>();
    dummySearchList.addAll(subservices);
    if (query.isNotEmpty) {
      List<SubService> dummyListData = List<SubService>();
      dummySearchList.forEach((item) {
        if (item.title.toLowerCase().contains(query.toLowerCase()) ||
            item.description.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        searchedsubservices.clear();
        searchedsubservices.addAll(dummyListData);
      });
      print(
          "this are the filtered number of subservices ${searchedsubservices.length}");
      return;
    } else {
      print('Query seems to be empty');
      setState(() {
        searchedsubservices.clear();
        searchedsubservices.addAll(subservices);
      });
    }
  }

  List<SubService> getSubServices() {
    return widget.service.services;
  }
}
