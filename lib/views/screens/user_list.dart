import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mans_memory/constants/keys.dart';
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
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => userRegistration(),
                ),
              );
              //   showModalBottomSheet(
              //     context: context,
              //     isScrollControlled: true,
              //     shape: const RoundedRectangleBorder(
              //       borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
              //     ),
              //     builder: (BuildContext context) {
              //       return userRegistrationDialog(users, context);
              //     },
              //   );
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

  Widget userRegistration() {
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
                  // onChanged: (text) {
                  //   model.newName = text.trim();
                  // },
                ),
                const SizedBox(height: 15),
                Center(
                  child: Column(
                    children: <Widget>[
                      const Text('登録ユーザーの名前を入力してください。'),
                      // const SizedBox(
                      //   height: 8,
                      // ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        child: const Text('作成'),
                        onPressed: () async {
                          // model.startLoading();
                          // try {
                          //   await model.updateName();
                          //   await _showTextDialog(context, 'ニックネームを変更しました');
                          //   Navigator.of(context).pop();
                          // } catch (e) {
                          //   _showTextDialog(context, e.toString());
                          // }
                          // model.endLoading();
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

  _showTextDialog(context, message) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget userRegistrationDialog(UserRepository users, BuildContext context) {
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
                  if (_userDataTable.data['name']!.text.isNotEmpty) {
                    users.add(
                      name: _userDataTable.data[NAME]!.text,
                      furigana: _userDataTable.data[FURIGANA]!.text,
                      birthday: Timestamp.fromDate(
                          DateTime.parse(_userDataTable.data[BIRTHDAY]!.text)),
                      hobby: [_userDataTable.data[HOBBY]!.text],
                      holiday: [false, false],
                      birthplace: _userDataTable.data[BIRTHPLACE]!.text,
                      residence: _userDataTable.data[RESIDENCE]!.text,
                      occupation: _userDataTable.data[OCCUPATION]!.text,
                      educationalBackground:
                          _userDataTable.data[EDUCATIONAL_BACKGROUND]!.text,
                      annualIncome: 1,
                      image: null,
                    );
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

    // NAME
    // FURIGANA
    // BIRTHDAY
    widgetsList.add(textInputField(
        userDataConvertedToJP[NAME]!, _userDataTable.data[NAME]!));
    widgetsList.add(textInputField(
        userDataConvertedToJP[FURIGANA]!, _userDataTable.data[FURIGANA]!));
    widgetsList.add(dateInputField(context, userDataConvertedToJP[BIRTHDAY]!,
        _userDataTable.data[BIRTHDAY]!));

    widgetsList.add(const SizedBox(height: 40));

    // HOBBY
    // HOLIDAY
    // BIRTHPLACE
    // RESIDENCE
    widgetsList.add(dateInputField(
        context, userDataConvertedToJP[HOBBY]!, _userDataTable.data[HOBBY]!));
    widgetsList.add(dateInputField(context, userDataConvertedToJP[HOLIDAY]!,
        _userDataTable.data[HOLIDAY]!));
    widgetsList.add(dateInputField(context, userDataConvertedToJP[BIRTHPLACE]!,
        _userDataTable.data[BIRTHPLACE]!));
    widgetsList.add(dateInputField(context, userDataConvertedToJP[RESIDENCE]!,
        _userDataTable.data[RESIDENCE]!));

    widgetsList.add(const SizedBox(height: 40));

    // EDUCATIONAL_BACKGROUND
    // OCCUPATION
    // ANNUAL_INCOME
    widgetsList.add(dateInputField(
        context,
        userDataConvertedToJP[EDUCATIONAL_BACKGROUND]!,
        _userDataTable.data[EDUCATIONAL_BACKGROUND]!));
    widgetsList.add(dateInputField(context, userDataConvertedToJP[OCCUPATION]!,
        _userDataTable.data[OCCUPATION]!));
    widgetsList.add(dateInputField(
        context,
        userDataConvertedToJP[ANNUAL_INCOME]!,
        _userDataTable.data[ANNUAL_INCOME]!));

    widgetsList.add(const SizedBox(height: 50));
    return widgetsList;
  }
}
