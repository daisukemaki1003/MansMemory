import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mans_memory/models/user.dart';
import 'package:mans_memory/provider/user_provider.dart';
import 'package:mans_memory/views/screens/user_details.dart';
import 'package:mans_memory/views/widgets/loading.dart';

import '../widgets/input_field/date_input_field.dart';
import '../widgets/input_field/text_input_field.dart';

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
        title: const Text("Title"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                ),
                builder: (BuildContext context) {
                  return userRegistrationDialog(users, context);
                },
              );
            },
          ),
          const SizedBox(width: 5),
        ],
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: users.fetch(),
          builder: (context, AsyncSnapshot<List<User>> snapshot) {
            if (!snapshot.hasData) {
              return loading();
            }
            final userList = snapshot.data!;
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
                        key: Key(user.name),
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
                        onDismissed: (direction) => userList.remove(user),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 32.0,
                            vertical: 3.0,
                          ),
                          leading: CircleAvatar(
                            radius: 25,
                            child: ClipOval(
                              child: Image.network(user.image ??
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
                              return MyTabbedPage(user);
                            }));
                          },
                          // onTap: () => ref.read(pageProvider.state).state = 1,
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

  Widget userRegistrationDialog(UserRepository users, BuildContext context) {
    // UserTextEditingController controller = UserTextEditingController();
    UserDataTable _userDataTable = UserDataTable();
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
              "ユーザー作成",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            elevation: 0,
            actions: [
              TextButton(
                onPressed: () {
                  if (_userDataTable.table1['name']!.text.isNotEmpty) {
                    users.add(_userDataTable);
                  } else {
                    print("データが存在しません");
                  }
                },
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
        child: Column(children: inputFieldList(_userDataTable, context)),
      ),
    );
  }

  List<Widget> inputFieldList(
      UserDataTable _userDataTable, BuildContext context) {
    List<Widget> widgetsList = [];
    widgetsList.add(Container(
      height: 200,
      width: double.infinity,
      color: Colors.grey,
    ));
    _userDataTable.table1.forEach((key, value) {
      if (key == 'birthday') {
        widgetsList.add(
            dateInputField(context, userDataConvertedToJapanese[key]!, value));
      } else {
        widgetsList
            .add(textInputField(userDataConvertedToJapanese[key]!, value));
      }
    });
    widgetsList.add(const SizedBox(height: 40));
    _userDataTable.table2.forEach((key, value) {
      widgetsList.add(textInputField(userDataConvertedToJapanese[key]!, value));
    });
    widgetsList.add(const SizedBox(height: 40));
    _userDataTable.table3.forEach((key, value) {
      widgetsList.add(textInputField(userDataConvertedToJapanese[key]!, value));
    });
    widgetsList.add(const SizedBox(height: 50));
    return widgetsList;
  }
}
