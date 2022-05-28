import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mans_memory/provider/user_provider.dart';

import '../../models/edit_user.dart';
import '../../models/user.dart';
import '../../provider/authentication_provider.dart';

class UserEditScreen extends ConsumerWidget {
  UserEditScreen(this.user, {Key? key}) : super(key: key);
  final UserModel user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);
    final users = ref.watch(usersProvider);
    final editUser = EditUser(user);

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
                child: const Text(
                  "保存",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.blue),
                ),
                onPressed: () async {
                  try {
                    await users.set(currentUser!.uid, user.uid, editUser);
                  } catch (e) {
                    print(e.toString());
                    final snackBar = SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(e.toString()),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          // Container(
          //   height: 200,
          //   width: double.infinity,
          //   color: Colors.grey,
          // ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            child: TextField(
              controller: editUser.nameController,
              cursorColor: Colors.black12,
              onChanged: (value) => editUser.setName(value),
              decoration: InputDecoration(
                labelText: '名前',
                labelStyle: const TextStyle(color: Colors.black),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                contentPadding: const EdgeInsets.only(
                    left: 20, top: 0, bottom: 3, right: 10),
                focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue)),
                suffix: IconButton(
                  icon: const Icon(Icons.clear, color: Colors.black54),
                  onPressed: () {
                    editUser.nameController.clear();
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            child: TextField(
              controller: editUser.furiganaController,
              cursorColor: Colors.black12,
              onChanged: (value) => editUser.setFurigana(value),
              decoration: InputDecoration(
                labelText: 'ふりがな',
                labelStyle: const TextStyle(color: Colors.black),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                contentPadding: const EdgeInsets.only(
                    left: 20, top: 0, bottom: 3, right: 10),
                focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue)),
                suffix: IconButton(
                  icon: const Icon(Icons.clear, color: Colors.black54),
                  onPressed: () {
                    editUser.furiganaController.clear();
                  },
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            child: TextField(
              readOnly: true,
              controller: editUser.birthdayController,
              cursorColor: Colors.black12,
              decoration: InputDecoration(
                labelText: '生年月日',
                labelStyle: const TextStyle(color: Colors.black),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                contentPadding: const EdgeInsets.only(
                    left: 20, top: 0, bottom: 3, right: 20),
                focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue)),
                suffix: TextButton(
                  child: const Text(
                    '編集',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Color.fromARGB(255, 92, 136, 169),
                    ),
                  ),
                  onPressed: () {
                    showCupertinoModalPopup<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              decoration: const BoxDecoration(
                                color: Color(0xffffffff),
                                border: Border(
                                  bottom: BorderSide(
                                    color: Color(0xff999999),
                                    width: 0.0,
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  CupertinoButton(
                                    child: const Text(
                                      'キャンセル',
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                    onPressed: () => Navigator.pop(context),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0,
                                      vertical: 5.0,
                                    ),
                                  ),
                                  CupertinoButton(
                                    child: const Text(
                                      '追加',
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                    onPressed: () {
                                      // editUser.setBirthday(
                                      //     editUser.birthdayController.text);
                                      Navigator.pop(context);
                                    },
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0,
                                      vertical: 5.0,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: 216,
                              padding: const EdgeInsets.only(top: 6.0),
                              color: CupertinoColors.white,
                              child: DefaultTextStyle(
                                style: const TextStyle(
                                  color: CupertinoColors.black,
                                  fontSize: 22.0,
                                ),
                                child: GestureDetector(
                                  onTap: () {},
                                  child: SafeArea(
                                    top: false,
                                    child: CupertinoDatePicker(
                                      mode: CupertinoDatePickerMode.date,
                                      initialDateTime: user.birthday,
                                      onDateTimeChanged:
                                          (DateTime newDateTime) {
                                        editUser.setBirthday(newDateTime);
                                        editUser.birthdayController.text =
                                            DateFormat('yyyy年M月d日')
                                                .format(newDateTime);
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),

          const SizedBox(height: 40),
          // textInputField('趣味', hobbyController),
          // textInputField('休日', holidayController),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            child: TextField(
              controller: editUser.birthplaceController,
              cursorColor: Colors.black12,
              onChanged: (value) => editUser.setBirthplace(value),
              decoration: InputDecoration(
                labelText: '出身地',
                labelStyle: const TextStyle(color: Colors.black),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                contentPadding: const EdgeInsets.only(
                    left: 20, top: 0, bottom: 3, right: 10),
                focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue)),
                suffix: IconButton(
                  icon: const Icon(Icons.clear, color: Colors.black54),
                  onPressed: () {
                    editUser.birthplaceController.clear();
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            child: TextField(
              controller: editUser.residenceController,
              cursorColor: Colors.black12,
              onChanged: (value) => editUser.setResidence(value),
              decoration: InputDecoration(
                labelText: '居住地',
                labelStyle: const TextStyle(color: Colors.black),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                contentPadding: const EdgeInsets.only(
                    left: 20, top: 0, bottom: 3, right: 10),
                focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue)),
                suffix: IconButton(
                  icon: const Icon(Icons.clear, color: Colors.black54),
                  onPressed: () {
                    editUser.residenceController.clear();
                  },
                ),
              ),
            ),
          ),

          const SizedBox(height: 40),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            child: TextField(
              controller: editUser.educationalBackgroundController,
              cursorColor: Colors.black12,
              onChanged: (value) => editUser.setEducationalBackground(value),
              decoration: InputDecoration(
                labelText: '学歴',
                labelStyle: const TextStyle(color: Colors.black),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                contentPadding: const EdgeInsets.only(
                    left: 20, top: 0, bottom: 3, right: 10),
                focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue)),
                suffix: IconButton(
                  icon: const Icon(Icons.clear, color: Colors.black54),
                  onPressed: () {
                    editUser.educationalBackgroundController.clear();
                  },
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            child: TextField(
              controller: editUser.occupationController,
              cursorColor: Colors.black12,
              onChanged: (value) => editUser.setOccupation(value),
              decoration: InputDecoration(
                labelText: '職種',
                labelStyle: const TextStyle(color: Colors.black),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                contentPadding: const EdgeInsets.only(
                    left: 20, top: 0, bottom: 3, right: 10),
                focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue)),
                suffix: IconButton(
                  icon: const Icon(Icons.clear, color: Colors.black54),
                  onPressed: () {
                    editUser.occupationController.clear();
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            child: TextField(
              controller: editUser.annualIncomeController,
              cursorColor: Colors.black12,
              onChanged: (value) => editUser.setAnnualIncome(value),
              decoration: InputDecoration(
                labelText: '年収',
                labelStyle: const TextStyle(color: Colors.black),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                contentPadding: const EdgeInsets.only(
                    left: 20, top: 0, bottom: 3, right: 10),
                focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue)),
                suffix: IconButton(
                  icon: const Icon(Icons.clear, color: Colors.black54),
                  onPressed: () {
                    editUser.annualIncomeController.clear();
                  },
                ),
              ),
            ),
          ),

          const SizedBox(height: 100),
        ]),
      ),
    );
  }
}
