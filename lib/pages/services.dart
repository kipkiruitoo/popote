import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:huduma_popote/models/service.dart';
import 'package:huduma_popote/pages/departments.dart';
import 'package:huduma_popote/pages/landingPage.dart';
import 'package:huduma_popote/pages/subservices.dart';

import 'huduma_services.dart';

class ServicesPage extends StatefulWidget {
  @override
  _ServicesPageState createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  bool _search = false;

  // List<Service> services;
  @override
  void initState() {
    super.initState();
    // services  =  getServices();
  }

  @override
  void dispose() {
    ScrollController().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            leading: Image.asset("assets/images/logo.png"),
            title: Text(
              "Huduma Online",
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(55),
              child: Container(
                child: Container(
                  padding: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.red, Colors.black]),
                  ),
                  child: TabBar(
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.white,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicator: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                          color: Colors.white),
                      tabs: [
                        Tab(
                            child: Text(
                          "Home",
                          // style: TextStyle(color: Colors.black),
                        )),
                        Tab(
                            child: Text(
                          "Life Events",
                          // style: TextStyle(color: Colors.black),
                        )),
                        Tab(
                            child: Text(
                          "Centers",
                          // style: TextStyle(color: Colors.black),
                        )),
                        Tab(
                            child: Text(
                          "MDAs",
                          // style: TextStyle(color: Colors.black),
                        ))
                      ]),
                ),
              ),
            ),
          ),
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: CustomScrollView(
              slivers: [
                // SliverToBoxAdapter(
                //   child: Container(
                //     padding: EdgeInsets.all(10),
                //     child: TabBar(
                //         indicatorColor: Colors.red,
                //         unselectedLabelColor: Colors.black.withOpacity(0.5),
                //         labelColor: Colors.black,
                //         tabs: [
                //           Tab(
                //             child: Text("Government Services",
                //                 textAlign: TextAlign.center,
                //                 style: TextStyle(
                //                   color: Colors.black,
                //                 )),
                //           ),
                //           Tab(
                //             child: Text("Huduma Centers",
                //                 textAlign: TextAlign.center,
                //                 style: TextStyle(color: Colors.black)),
                //           ),
                //           Tab(
                //             child: Text("Departments",
                //                 textAlign: TextAlign.center,
                //                 style: TextStyle(color: Colors.black)),
                //           )
                //         ]),
                //   ),
                // ),
                SliverToBoxAdapter(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.75,
                    child: TabBarView(
                      children: [
                        LandingPage(),
                        FutureBuilder(
                          key: PageStorageKey("life-events"),
                          future: DefaultAssetBundle.of(context)
                              .loadString('assets/data/life-events.json'),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              List<Service> services =
                                  parseJosn(snapshot.data.toString());
                              return Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.8,
                                child: GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                  ),
                                  itemBuilder: (ctx, index) {
                                    return ServiceCard(
                                        service: services[index]);
                                  },
                                  itemCount: services.length,
                                ),
                              );
                            }
                          },
                        ),
                        HudumaCenter(),
                        DepartmentsPage(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  List<Service> parseJosn(String response) {
    if (response == null) {
      return [];
    }
    final parsed =
        json.decode(response.toString()).cast<Map<String, dynamic>>();
    return parsed.map<Service>((json) => new Service.fromJson(json)).toList();
  }

  Widget searchField() {
    return Container(
      child: TextField(
        autofocus: false,
        style: TextStyle(color: Color(0xFFB40284A), fontSize: 18),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: Color(0xFFB40284A),
          ),
          hintStyle: TextStyle(
              color: Color(0xFFB40284A).withOpacity(0.5), fontSize: 12),
          hintText: "Start typing to Search",
          // enabledBorder: UnderlineInputBorder(
          //   borderSide: BorderSide(color: Color(0xFFB40284A), width: 1),
          // ), //under line border, set OutlineInputBorder() for all side border
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFB40284A), width: 1),
          ), // focused border color
        ), //decoration for search input field
        onChanged: (value) {
          //update the value of query
          // getSuggestion(value); //start to get suggestion
        },
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  Service service;
  ServiceCard({this.service}) {
    service = this.service;

    // print(service.image);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
          return SubServicePage(
            service: service,
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
                Image.asset(
                  "assets/images/${service.image}",
                  width: 65,
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    service.name,
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
