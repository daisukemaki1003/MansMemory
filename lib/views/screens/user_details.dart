import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mans_memory/provider/user_provider.dart';

class MyTabbedPage extends StatefulWidget {
  const MyTabbedPage({Key? key}) : super(key: key);
  @override
  UserDetailsScreen createState() => UserDetailsScreen();
}

class UserDetailsScreen extends State with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> tabWidgets = [
      Column(
        children: [
          Container(
            height: 180,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 242, 242, 242),
                borderRadius: BorderRadius.circular(30)),
            child: Padding(
              padding: const EdgeInsets.only(top: 30.0, left: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "基本情報",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
                  ),
                  profileWidget('名前', 'maki'),
                  profileWidget('ふりがな', 'daisuke'),
                  profileWidget('年齢', '21'),
                ],
              ),
            ),
          ),
          Container(
            height: 180,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 242, 242, 242),
                borderRadius: BorderRadius.circular(30)),
            child: Padding(
              padding: const EdgeInsets.only(top: 30.0, left: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "基本情報",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
                  ),
                  profileWidget('名前', 'maki'),
                  profileWidget('ふりがな', 'daisuke'),
                  profileWidget('年齢', '21'),
                ],
              ),
            ),
          ),
          Container(
            height: 180,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 242, 242, 242),
                borderRadius: BorderRadius.circular(30)),
            child: Padding(
              padding: const EdgeInsets.only(top: 30.0, left: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "基本情報",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
                  ),
                  profileWidget('名前', 'maki'),
                  profileWidget('ふりがな', 'daisuke'),
                  profileWidget('年齢', '21'),
                ],
              ),
            ),
          ),
        ],
      ),
      Column(
        children: [
          Container(
            height: 300,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 242, 242, 242),
                borderRadius: BorderRadius.circular(30)),
            child: Padding(
              padding: const EdgeInsets.only(top: 30.0, left: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "基本情報",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
                  ),
                  profileWidget('名前', 'maki'),
                  profileWidget('ふりがな', 'daisuke'),
                  profileWidget('年齢', '21'),
                ],
              ),
            ),
          ),
          Container(
            height: 300,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 242, 242, 242),
                borderRadius: BorderRadius.circular(30)),
            child: Padding(
              padding: const EdgeInsets.only(top: 30.0, left: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "基本情報",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
                  ),
                  profileWidget('名前', 'maki'),
                  profileWidget('ふりがな', 'daisuke'),
                  profileWidget('年齢', '21'),
                ],
              ),
            ),
          ),
          Container(
            height: 300,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 242, 242, 242),
                borderRadius: BorderRadius.circular(30)),
            child: Padding(
              padding: const EdgeInsets.only(top: 30.0, left: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "基本情報",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
                  ),
                  profileWidget('名前', 'maki'),
                  profileWidget('ふりがな', 'daisuke'),
                  profileWidget('年齢', '21'),
                ],
              ),
            ),
          ),
        ],
      )
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                expandedHeight: 200,
                backgroundColor: const Color.fromARGB(255, 76, 141, 195),
                pinned: true,
                elevation: 2,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  // centerTitle: true,
                  background: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 100,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: const [
                                Text(
                                  "牧大佑",
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "まきだいすけ",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "2000/10/03",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                CircleAvatar(
                                  radius: 35,
                                  backgroundImage: const NetworkImage(
                                      "https://gws-ug.jp/wp-content/plugins/all-in-one-seo-pack/images/default-user-image.png"),
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: const [
                                        CircleAvatar(
                                          radius: 10,
                                          backgroundColor: Colors.white,
                                        ),
                                        CircleAvatar(
                                          radius: 8,
                                          backgroundColor: Colors.blue,
                                        ),
                                        Icon(
                                          Icons.add,
                                          color: Colors.white,
                                          size: 14,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                bottom: TabBar(
                  tabs: const <Widget>[
                    Tab(text: "プロフィール"),
                    Tab(text: "プロフィール"),
                  ],
                  controller: _tabController,
                ),
              ),
            )
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: tabWidgets.map((Widget w) {
            return SafeArea(
              top: false,
              bottom: false,
              child: Builder(
                builder: (BuildContext context) {
                  return CustomScrollView(
                    shrinkWrap: true,
                    slivers: <Widget>[
                      SliverOverlapInjector(
                        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                            context),
                      ),
                      SliverList(
                        delegate: SliverChildListDelegate([w]),
                      ),
                    ],
                  );
                },
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Padding profileWidget(String key, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              key,
              style: const TextStyle(fontSize: 15.0, color: Colors.black54),
            ),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 15.0, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
