import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mans_memory/models/acquaintance.dart';
import 'package:mans_memory/provider/acquaintance.dart';
import 'package:mans_memory/views/screens/acquaintance_details.dart';
import 'package:mans_memory/views/widgets/loading.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../provider/authentication.dart';
import 'terms_of_service.dart';

class AcquaintanceListScreen extends ConsumerWidget {
  const AcquaintanceListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final acquaintanceProvider = ref.watch(acquaintanceStateProvider);
    final authentication = ref.watch(authenticationProvider);
    final userProvider = ref.watch(currentUserProvider);

    // var selectedAcquaintance = ref.watch(selectedStateAcquaintance);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () async {
            showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ListTile(
                          title: const Text('利用規約'),
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return const TermsOfServiceScreen();
                            }));
                          },
                        ),
                        ListTile(
                            title: const Text('問い合わせ'),
                            onTap: () {
                              Navigator.of(context).pop();
                              openUrl();
                            }),
                        ListTile(
                          title: const Text('ログアウト'),
                          onTap: () {
                            Navigator.of(context).pop();
                            authentication.signOut();
                          },
                        ),
                        const SizedBox(height: 50),
                      ],
                    ),
                  );
                });
          },
        ),
        // title: const Text("友達のーと"),
        title: const Text(
            bool.fromEnvironment('dart.vm.product') ? "友達のーと" : "友達のーと(開発)"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      UserRegistration(userProvider!, acquaintanceProvider),
                ),
              );
            },
          ),
          const SizedBox(width: 5),
        ],
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: acquaintanceProvider.fetchStream(userProvider!.uid),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return loading();
            }
            List<AcquaintanceModel> acquaintanceList = snapshot.data!.docs
                .map((DocumentSnapshot document) =>
                    acquaintanceProvider.acquaintanceCreate(document))
                .toList();
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: const ScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: acquaintanceList.length,
                    itemBuilder: (context, index) {
                      final acquaintance = acquaintanceList[index];
                      return Dismissible(
                        key: ObjectKey(acquaintance),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          alignment: Alignment.centerRight,
                          color: Colors.redAccent[700],
                          child: const Padding(
                              padding:
                                  EdgeInsets.fromLTRB(10.0, 0.0, 20.0, 0.0),
                              child: Icon(Icons.delete, color: Colors.white)),
                        ),
                        confirmDismiss: (DismissDirection direction) async {
                          return await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("確認"),
                                content: const Text("削除します。よろしいですか？"),
                                actions: [
                                  TextButton(
                                      onPressed: () async {
                                        Navigator.of(context).pop(true);
                                        acquaintanceProvider.delete(
                                            userId: userProvider.uid,
                                            acquaintanceId:
                                                acquaintance.acquaintanceId);
                                      },
                                      child: const Text(
                                        "削除",
                                        style: TextStyle(color: Colors.black),
                                      )),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(false),
                                    child: const Text("キャンセル",
                                        style: TextStyle(color: Colors.black)),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 32.0,
                            vertical: 8.0,
                          ),
                          leading: CircleAvatar(
                            radius: 25,
                            child: ClipOval(
                              child: Image.network(acquaintance.icon.isNotEmpty
                                  ? acquaintance.icon
                                  : "https://gws-ug.jp/wp-content/plugins/all-in-one-seo-pack/images/default-user-image.png"),
                            ),
                          ),
                          title: Text(acquaintance.name),
                          // trailing: acquaintance.birthday != null
                          //     ? Text(DateFormat('yyyy年M月d日')
                          //         .format(acquaintance.birthday))
                          //     : const Text(""),
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              // selectedAcquaintance = acquaintance;
                              return MyTabbedPage(acquaintance.acquaintanceId);
                            }));
                          },
                        ),
                      );
                    },
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void openUrl() async {
    const url = 'https://twitter.com/Tc48AyMVVfuUOjM';
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
      );
    } else {
      throw 'このURLにはアクセスできません';
    }
  }

  Future<bool?> dismissed_dialog(BuildContext context, AcquaintanceModel user) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: const Text("削除の確認"),
          content: Text("『${user.name}』を削除しますか？"),
          actions: [
            TextButton(
              child: const Text("いいえ"),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            TextButton(
              child: const Text("はい"),
              onPressed: () async {
                Navigator.of(context).pop(true);
                final snackBar = SnackBar(
                  backgroundColor: Colors.red,
                  content: Text('${user.name}を削除しました'),
                );
              },
            ),
          ],
        );
      },
    );
  }
}

class UserRegistration extends StatelessWidget {
  UserRegistration(this.currentUser, this.acquaintance, {Key? key})
      : super(key: key);
  User currentUser;
  acquaintanceNotifier acquaintance;

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('ユーザー作成'),
      ),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text('名前は後から変更できます。'),
                TextField(
                  autofocus: true,
                  controller: nameController,
                  decoration: InputDecoration(
                    focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    suffix: IconButton(
                      icon: const Icon(
                        Icons.clear,
                        color: Colors.black54,
                      ),
                      onPressed: () {
                        nameController.clear();
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Center(
                  child: Column(
                    children: <Widget>[
                      const Text('登録ユーザーの名前を入力してください。'),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        child: const Text('作成'),
                        onPressed: () async {
                          try {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              },
                            );
                            final userId = await acquaintance.create(
                                currentUser.uid, nameController.text.trim());

                            Navigator.of(context).pop();
                            final result =
                                await _showTextDialog(context, 'ユーザーを作成しました。');

                            if (result != null && result) {
                              Navigator.of(context).pop();
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => MyTabbedPage(userId)));
                            } else {
                              Navigator.of(context).pop();
                            }
                          } catch (e) {
                            _showErrorDialog(context, e.toString());
                          }
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          // model.isLoading
          //     ? Container(
          //         color: Colors.black.withOpacity(0.3),
          //         child: Center(
          //           child: CircularProgressIndicator(),
          //         ),
          //       )
          //     : SizedBox()
        ],
      ),
    );
  }

  Future<bool?> _showTextDialog(context, message) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(message),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actionsPadding: const EdgeInsets.symmetric(horizontal: 15),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'ホームへ',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            TextButton(
              child: const Text(
                '編集画面へ',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        );
      },
    );
  }

  _showErrorDialog(context, message) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: Text(message),
            actionsAlignment: MainAxisAlignment.spaceBetween,
            actionsPadding: const EdgeInsets.symmetric(horizontal: 15));
      },
    );
  }
}
