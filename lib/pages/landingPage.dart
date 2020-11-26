import 'package:flutter/material.dart';
import 'package:huduma_popote/data/data.dart';
import 'package:huduma_popote/widgets/widgets.dart';

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
          child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              // color: Colors.yellowAccent,
              // height: 1000,
            ),
          ),
                SliverToBoxAdapter(
              child: ContentList(
                key: PageStorageKey('contentList'),
                title: 'Life Events',
                contentList: myList,
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
                child: ContentList(
                  key: PageStorageKey('trending'),
                  title: 'Trending Services',
                  contentList: trending,
                ),
              ),
            )
        ],
      )),
    );
  }
}
