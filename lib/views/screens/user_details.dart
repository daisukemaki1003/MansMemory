import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mans_memory/provider/user_provider.dart';

class UserDetailsScreen extends ConsumerWidget {
  UserDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15.0, left: 20.0),
              child: Row(
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 45,
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
                  const SizedBox(width: 20),
                  // User name
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "maki",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 27,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "2000/10/03",
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                side: const BorderSide(
                  color: Colors.black12, //色
                  width: 1.5, //太さ
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  "プロフィールを編集",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
              ),
              onPressed: () {},
            ),
            Container(
              height: 3000,
              child: Expanded(
                child: DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      TabBar(
                        labelColor: Theme.of(context).primaryColor,
                        isScrollable: true,
                        tabs: const [
                          Tab(
                            text: 'account',
                            icon: Icon(Icons.account_box),
                          ),
                          Tab(
                            text: 'calender',
                            icon: Icon(Icons.calendar_month),
                          )
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            Column(
                              children: [
                                test(),
                                Container(
                                  height: 180,
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 242, 242, 242),
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 30.0, left: 40.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "基本情報",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15.0),
                                        ),
                                        profile('名前', 'maki'),
                                        profile('ふりがな', 'daisuke'),
                                        profile('年齢', '21'),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 180,
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 242, 242, 242),
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 30.0, left: 40.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "嗜好",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15.0),
                                        ),
                                        profile('趣味', 'アニメ'),
                                        profile('趣味', 'サッカー'),
                                        profile('趣味', '将棋'),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 180,
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 242, 242, 242),
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 30.0, left: 40.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "経歴",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15.0),
                                        ),
                                        profile('学歴', '東京大学'),
                                        profile('職種', 'エンジニア'),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [for (var i = 0; i < 100; i++) test()],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget test() {
    return Container(
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
            profile('名前', 'maki'),
            profile('ふりがな', 'daisuke'),
            profile('年齢', '21'),
          ],
        ),
      ),
    );
  }

  Padding profile(String key, String value) {
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
