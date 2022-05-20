import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mans_memory/models/user.dart';
import 'package:mans_memory/provider/user_provider.dart';
import 'package:mans_memory/views/screens/user_details.dart';
import 'package:mans_memory/views/widgets/loading.dart';

class UserListScreen extends ConsumerWidget {
  const UserListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(usersProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () async {},
        ),
        title: const Text("マンメモ"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserRegistration(users),
                ),
              );
            },
          ),
          const SizedBox(width: 5),
        ],
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: users.fetchStream(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return loading();
            }
            // final userList = snapshot.data!;
            List<User> userList = snapshot.data!.docs
                .map((DocumentSnapshot document) => users.userCreate(document))
                .toList();
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: const ScrollPhysics(),
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: userList.length,
                    itemBuilder: (context, index) {
                      final user = userList[index];
                      return Dismissible(
                        key: ObjectKey(user),
                        background: Container(
                          padding: const EdgeInsets.only(
                            right: 10,
                          ),
                          alignment: AlignmentDirectional.centerEnd,
                          color: Colors.red,
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) => users.delete(user.uid),
                        // onDismissed: (direction) => userList.remove(user),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 32.0,
                            vertical: 3.0,
                          ),
                          leading: CircleAvatar(
                            radius: 25,
                            child: ClipOval(
                              child: Image.network(user.icon ??
                                  "https://gws-ug.jp/wp-content/plugins/all-in-one-seo-pack/images/default-user-image.png"),
                            ),
                          ),
                          title: Text(user.name),
                          subtitle: Text(user.furigana ?? ""),
                          trailing: user.birthday != null
                              ? Text(DateFormat('yyyy年M月d日')
                                  .format(user.birthday!))
                              : const Text(""),
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return MyTabbedPage(user.uid);
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

//   Widget userRegistration(BuildContext context, UserRepository users) {
//     final TextEditingController nameController = TextEditingController();

//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text('ユーザー作成'),
//       ),
//       body: Stack(
//         children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.all(8),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 const Text('名前は後から変更できます。'),
//                 TextField(
//                   autofocus: true,
//                   controller: nameController,
//                   decoration: InputDecoration(
//                     focusedBorder: const UnderlineInputBorder(
//                         borderSide: BorderSide(color: Colors.black)),
//                     suffix: IconButton(
//                       icon: const Icon(
//                         Icons.clear,
//                         color: Colors.black54,
//                       ),
//                       onPressed: () {
//                         nameController.clear();
//                       },
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 15),
//                 Center(
//                   child: Column(
//                     children: <Widget>[
//                       const Text('登録ユーザーの名前を入力してください。'),
//                       const SizedBox(height: 30),
//                       ElevatedButton(
//                         child: const Text('作成'),
//                         onPressed: () async {
//                           try {
//                             final userId =
//                                 await users.add(nameController.text.trim());
//                             final result =
//                                 await _showTextDialog(context, 'ユーザーを作成しました。');

//                             if (result != null && result) {
//                               Navigator.of(context).pop();
//                               Navigator.of(context).push(MaterialPageRoute(
//                                   builder: (context) => MyTabbedPage(userId)));
//                             } else {
//                               Navigator.of(context).pop();
//                             }
//                           } catch (e) {
//                             _showErrorDialog(context, e.toString());
//                           }
//                         },
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//           // model.isLoading
//           //     ? Container(
//           //         color: Colors.black.withOpacity(0.3),
//           //         child: Center(
//           //           child: CircularProgressIndicator(),
//           //         ),
//           //       )
//           //     : SizedBox()
//         ],
//       ),
//     );
//   }

//   Future<bool?> _showTextDialog(context, message) async {
//     return await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(message),
//           actionsAlignment: MainAxisAlignment.spaceBetween,
//           actionsPadding: const EdgeInsets.symmetric(horizontal: 15),
//           actions: <Widget>[
//             TextButton(
//               child: const Text(
//                 'ホームへ',
//                 style: TextStyle(color: Colors.black),
//               ),
//               onPressed: () => Navigator.of(context).pop(false),
//             ),
//             TextButton(
//               child: const Text(
//                 '編集画面へ',
//                 style: TextStyle(color: Colors.black),
//               ),
//               onPressed: () => Navigator.of(context).pop(true),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   _showErrorDialog(context, message) async {
//     await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//             title: Text(message),
//             actionsAlignment: MainAxisAlignment.spaceBetween,
//             actionsPadding: const EdgeInsets.symmetric(horizontal: 15));
//       },
//     );
//   }
}

class UserRegistration extends StatelessWidget {
  UserRegistration(this.users, {Key? key}) : super(key: key);
  UserRepository users;

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
                            final userId =
                                await users.add(nameController.text.trim());
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
