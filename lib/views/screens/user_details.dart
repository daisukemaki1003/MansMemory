import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mans_memory/models/user.dart';

import '../../provider/user_provider.dart';
import '../widgets/input_field/date_input_field.dart';
import '../widgets/input_field/text_input_field.dart';
import 'user_list.dart';

class MyTabbedPage extends StatefulWidget {
  const MyTabbedPage(this.user, {Key? key}) : super(key: key);
  final User user;

  @override
  UserDetailsScreen createState() => UserDetailsScreen(user);
}

class UserDetailsScreen extends State with SingleTickerProviderStateMixin {
  UserDetailsScreen(this.user);
  final User user;
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
                leading: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const UserListScreen(),
                      ));
                    }),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user.name,
                                  style: const TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  user.furigana ?? '',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  user.birthday != null
                                      ? DateFormat('yyyy年M月d日')
                                          .format(user.birthday!)
                                      : '',
                                  style: const TextStyle(
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
          children: [
            SafeArea(
              top: false,
              bottom: false,
              child: Stack(
                children: [
                  Builder(
                    builder: (BuildContext context) {
                      return CustomScrollView(
                        shrinkWrap: true,
                        slivers: <Widget>[
                          SliverOverlapInjector(
                              handle: NestedScrollView
                                  .sliverOverlapAbsorberHandleFor(context)),
                          SliverList(delegate: profileList()),
                        ],
                      );
                    },
                  ),
                  SafeArea(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 30.0),
                        child: TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor:
                                  Color.fromARGB(255, 76, 141, 195),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100))),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 13)),
                          child: const Text(
                            'プロフィールを編集',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(15)),
                              ),
                              builder: (BuildContext context) {
                                return userRegistrationDialog(context);
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SafeArea(
              top: false,
              bottom: false,
              child: Builder(
                builder: (BuildContext context) {
                  return CustomScrollView(
                    shrinkWrap: true,
                    slivers: <Widget>[
                      SliverOverlapInjector(
                          handle:
                              NestedScrollView.sliverOverlapAbsorberHandleFor(
                                  context)),
                      SliverList(delegate: SliverChildListDelegate([])),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  SliverChildListDelegate profileList() {
    return SliverChildListDelegate(
      [
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
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
                ),
                profileWidget('名前', user.name),
                profileWidget('ふりがな', user.furigana ?? '未設定'),
                // profileWidget('年齢', user.age!.toString()),
              ],
            ),
          ),
        ),
        Container(
          height: 230,
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
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
                ),
                profileWidget('出身地', user.birthplace ?? '未設定'),
                profileWidget('居住地', user.residence ?? '未設定'),
                profileWidget(
                    '趣味', user.hobby != null ? user.hobby.toString() : '未設定'),
                profileWidget('休日',
                    user.holiday != null ? user.holiday.toString() : '未設定'),
              ],
            ),
          ),
        ),
        Container(
          height: 200,
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
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
                ),
                profileWidget('学歴', user.educationalBackground ?? '未設定'),
                profileWidget('職種', user.occupation ?? '未設定'),
                profileWidget(
                    '年収',
                    user.annualIncome != null
                        ? user.annualIncome.toString()
                        : '未設定'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 130)
      ],
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

  Widget userRegistrationDialog(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey, //色
                spreadRadius: 4,
                blurRadius: 4,
                offset: Offset(1, 1),
              ),
            ],
          ),
          padding: const EdgeInsets.only(top: 50.0),
          child: AppBar(
            title: const Text(
              "ユーザー編集",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            elevation: 0,
            actions: [
              TextButton(
                onPressed: () {},
                child: const Text(
                  "保存",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: inputFieldList(context)),
      ),
    );
  }

  List<Widget> inputFieldList(BuildContext context) {
    List<Widget> widgetsList = [];
    widgetsList.add(Container(
      height: 200,
      width: double.infinity,
      color: Colors.grey,
    ));

    // NAME
    // FURIGANA
    // BIRTHDAY
    widgetsList.add(const SizedBox(height: 40));
    widgetsList.add(testField('名前'));
    widgetsList.add(testField('ふりがな'));
    widgetsList.add(testField('生年月日'));

    // HOBBY
    // HOLIDAY
    // BIRTHPLACE
    // RESIDENCE
    widgetsList.add(const SizedBox(height: 40));
    widgetsList.add(testField('趣味'));
    widgetsList.add(testField('休日'));
    widgetsList.add(testField('出身地'));
    widgetsList.add(testField('居住地'));

    // EDUCATIONAL_BACKGROUND
    // OCCUPATION
    // ANNUAL_INCOME
    widgetsList.add(const SizedBox(height: 40));
    widgetsList.add(testField('学歴'));
    widgetsList.add(testField('職種'));
    widgetsList.add(testField('年収'));

    widgetsList.add(const SizedBox(height: 50));
    return widgetsList;
  }

  Widget testField(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: TextField(
        cursorColor: Colors.black12,
        // controller: nameController,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.black),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          // helperText: '名前',
          // helperStyle: const TextStyle(color: Colors.black),
          contentPadding:
              const EdgeInsets.only(left: 20, top: 0, bottom: 3, right: 10),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blue)),
          suffix: IconButton(
            icon: const Icon(Icons.clear, color: Colors.black54),
            onPressed: () {
              // nameController.clear();
            },
          ),
        ),
      ),
    );
  }
}
