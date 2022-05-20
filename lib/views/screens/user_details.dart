import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mans_memory/models/user.dart';

import '../../provider/user_provider.dart';
import '../widgets/loading.dart';
import 'edit_user.dart';
import 'user_list.dart';

class MyTabbedPage extends ConsumerStatefulWidget {
  const MyTabbedPage(this.uid, {Key? key}) : super(key: key);
  final String uid;

  @override
  // ignore: no_logic_in_create_state
  UserDetailsScreen createState() => UserDetailsScreen(uid);
}

class UserDetailsScreen extends ConsumerState<MyTabbedPage>
    with SingleTickerProviderStateMixin {
  UserDetailsScreen(this.uid);

  final String uid;
  late TabController _tabController;
  // late User user;

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
    final users = ref.watch(usersProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: users.get(uid),
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          if (!snapshot.hasData) {
            return loading();
          }
          final user = snapshot.data!;
          return NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverOverlapAbsorber(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverAppBar(
                    expandedHeight: 200,
                    backgroundColor: const Color.fromARGB(255, 76, 141, 195),
                    pinned: true,
                    elevation: 2,
                    leading: IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new),
                        onPressed: () {
                          Navigator.of(context).pop(MaterialPageRoute(
                            builder: (context) => const UserListScreen(),
                          ));
                        }),
                    flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.pin,
                      background: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 120,
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
                                RawMaterialButton(
                                  onPressed: () async {
                                    try {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return const Center(
                                              child:
                                                  CircularProgressIndicator());
                                        },
                                      );
                                      await users.setImage(user.uid);
                                      Navigator.of(context).pop();
                                    } catch (e) {
                                      print(e);
                                    }
                                  },
                                  child: CircleAvatar(
                                    radius: 35,
                                    backgroundImage: NetworkImage(user.icon ??
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
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ];
            },
            body: SafeArea(
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
                          SliverList(delegate: profileList(user)),
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
                                  const Color.fromARGB(255, 76, 141, 195),
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
                                return UserEditScreen(user);
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
          );
        },
      ),
    );
  }

  SliverChildListDelegate profileList(User user) {
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
                // profileWidget(
                //     '趣味', user.hobby != null ? user.hobby.toString() : '未設定'),
                // profileWidget('休日',
                //     user.holiday != null ? user.holiday.toString() : '未設定'),
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
}
