import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:huduma_popote/data/data.dart';

import 'package:huduma_popote/models/service.dart';
import 'package:huduma_popote/models/subservice.dart';
import 'package:huduma_popote/pages/services.dart';
import 'package:huduma_popote/services/services.dart';
import 'package:huduma_popote/widgets/widgets.dart';

import 'package:random_color/random_color.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController()..addListener(() {});
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          key: PageStorageKey("homepage"),
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  height: 200,
                  key: PageStorageKey('life'),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 8.0),
                        child: Text(
                          "Life Events",
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(height: 160, child: EventsScroller()),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: ContentList(
                    key: PageStorageKey('originals'),
                    title: 'Popular Government Agencies',
                    contentList: originals,
                    isOriginals: true),
              ),
              SliverPadding(
                padding: EdgeInsets.only(bottom: 20.0),
                sliver: SliverToBoxAdapter(
                  child: TrendingServices(),
                ),
              )
            ],
          )),
    );
  }
}

// life events scroller

class EventsScroller extends StatefulWidget {
  @override
  _EventsScrollerState createState() => _EventsScrollerState();
}

class _EventsScrollerState extends State<EventsScroller> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DefaultAssetBundle.of(context)
          .loadString('assets/data/life-events.json'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          List<Service> services = parseJosn(snapshot.data.toString());
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (ctx, index) {
              return ServiceCard(service: services[index]);
            },
            itemCount: services.length,
          );
        }
      },
    );
  }

  List<Service> parseJosn(String response) {
    if (response == null) {
      return [];
    }
    final parsed =
        json.decode(response.toString()).cast<Map<String, dynamic>>();
    return parsed.map<Service>((json) => new Service.fromJson(json)).toList();
  }
}

// trending services page
class TrendingServices extends StatefulWidget {
  @override
  _TrendingServicesState createState() => _TrendingServicesState();
}

class _TrendingServicesState extends State<TrendingServices>
    with AutomaticKeepAliveClientMixin<TrendingServices> {
  bool isLoading = true;

  List<SubService> services = new List();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    fetchTrendingServices();
    super.initState();
  }

  fetchTrendingServices() async {
    String url = '/services/trending';

    var res = await PopoteService().getData(url);

    var body = json.decode(res.body);

    // print();
    if (!body["success"]) {
      return null;
    }

    var serviceList = body["results"];
    // print(serviceList);
    serviceList.forEach((element) {
      SubService service = new SubService(
          title: element["name"], description: element["details"]);

      setState(() {
        services.add(service);
      });
    });

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Text(
            "Trending Services",
            style: const TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
          ),
        ),
        !isLoading
            ? Container(
                height: 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 16.0),
                  itemCount: services.length,
                  itemBuilder: (ctx, index) {
                    final SubService service = services[index];

                    return GestureDetector(
                      onTap: () => print(service.title),
                      child: Container(
                        // color: randomOpaqueColor(),
                        decoration: BoxDecoration(
                          color: randomOpaqueColor(),
                          borderRadius: new BorderRadius.circular(16.0),
                        ),
                        margin: EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8.0),
                        height: 200,
                        width: 130.0,
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(5, 60, 5, 10),
                              child: Text(
                                service.title,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              )
      ]),
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
}
