import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mans_memory/models/acquaintance.dart';

import '../../models/acquaintance_holiday.dart';
import '../../provider/authentication.dart';
import '../../provider/acquaintance.dart';
import '../widgets/loading.dart';
import 'edit_acquaintance.dart';
import 'acquaintance_list.dart';

class MyTabbedPage extends ConsumerStatefulWidget {
  const MyTabbedPage(this.uid, {Key? key}) : super(key: key);
  final String uid;

  @override
  // ignore: no_logic_in_create_state
  AcquaintanceDetailsScreen createState() => AcquaintanceDetailsScreen(uid);
}

class AcquaintanceDetailsScreen extends ConsumerState<MyTabbedPage>
    with SingleTickerProviderStateMixin {
  AcquaintanceDetailsScreen(this.uid);

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
    final currentUser = ref.watch(currentUserProvider);
    final acquaintanceProvider = ref.watch(acquaintanceStateProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: acquaintanceProvider.get(currentUser!.uid, uid),
        builder:
            (BuildContext context, AsyncSnapshot<AcquaintanceModel> snapshot) {
          if (!snapshot.hasData) {
            return loading();
          }
          final acquaintance = snapshot.data!;
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
                            builder: (context) =>
                                const AcquaintanceListScreen(),
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
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        acquaintance.name,
                                        softWrap: false,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        DateFormat('登録日 yyyy年M月d日').format(
                                            acquaintance.createdAt.toDate()),
                                        style: const TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
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
                                      await acquaintanceProvider.setImage(
                                          userId: currentUser.uid,
                                          acquaintanceId:
                                              acquaintance.acquaintanceId);
                                      Navigator.of(context).pop();
                                    } catch (e) {
                                      Navigator.of(context).pop();
                                      showDialog(
                                          context: context,
                                          builder: (_) {
                                            return AlertDialog(
                                              title: Text(e.toString()),
                                              content: const Text(
                                                  "本アプリにカメラロールへのアクセス権が存在することをご確認ください。"),
                                            );
                                          });
                                    }
                                  },
                                  child: CircleAvatar(
                                    radius: 35,
                                    backgroundImage: NetworkImage(acquaintance
                                            .icon.isNotEmpty
                                        ? acquaintance.icon
                                        : "https://gws-ug.jp/wp-content/plugins/all-in-one-seo-pack/images/default-user-image.png"),
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
                          SliverList(delegate: profileList(acquaintance)),
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
                                return AcquaintanceEditScreen(
                                    acquaintance: acquaintance);
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  SliverChildListDelegate profileList(AcquaintanceModel acquaintance) {
    return SliverChildListDelegate(
      [
        Container(
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 242, 242, 242),
              borderRadius: BorderRadius.circular(30)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "基本情報",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
                ),
                const SizedBox(height: 20),
                profileWidget('名前', acquaintance.name),
                profileWidget('年齢',
                    acquaintance.age > 0 ? acquaintance.age.toString() : '未設定'),
                profileWidget(
                    '誕生日',
                    acquaintance.birthday.isNotEmpty
                        ? acquaintance.birthday
                        : '未設定'),
                profileWidget(
                    '出身地',
                    acquaintance.birthplace.isNotEmpty
                        ? acquaintance.birthplace
                        : '未設定'),
                profileWidget(
                    '居住地',
                    acquaintance.residence.isNotEmpty
                        ? acquaintance.residence
                        : '未設定'),
              ],
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 242, 242, 242),
              borderRadius: BorderRadius.circular(30)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "基本情報",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
                ),
                const SizedBox(height: 20),
                profileWidget(
                    '職種',
                    acquaintance.occupation.isNotEmpty
                        ? acquaintance.occupation
                        : '未設定'),
                profileWidget(
                    '休日',
                    acquaintance.holiday != 0
                        ? getHolidayText(acquaintance.holiday)
                        : '未設定'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 1),
        Container(
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 242, 242, 242),
              borderRadius: BorderRadius.circular(30)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 40),
            // padding: const EdgeInsets.only(top: 30.0, left: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "メモ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
                ),
                const SizedBox(height: 20),
                Text(
                  acquaintance.memo.isNotEmpty ? acquaintance.memo : '未設定',
                  style: const TextStyle(fontSize: 15.0, color: Colors.black),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 130),
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
          Expanded(
            child: Text(
              value,
              softWrap: true,
              style: const TextStyle(fontSize: 15.0, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
