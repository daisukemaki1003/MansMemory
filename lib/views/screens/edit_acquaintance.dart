import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mans_memory/provider/acquaintance.dart';

import '../../models/acquaintance.dart';
import '../../provider/authentication.dart';

class AcquaintanceEditScreen extends ConsumerWidget {
  AcquaintanceEditScreen(this.acquaintance, {Key? key}) : super(key: key);
  final AcquaintanceModel acquaintance;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProvider = ref.watch(currentUserProvider);
    final acquaintanceProvider = ref.watch(acquaintanceStateProvider);

    final nameController = TextEditingController(text: acquaintance.name);
    final ageController =
        TextEditingController(text: acquaintance.age.toString());
    final birthdayController =
        TextEditingController(text: acquaintance.birthday);
    final birthplaceController =
        TextEditingController(text: acquaintance.birthplace);
    final residenceController =
        TextEditingController(text: acquaintance.residence);
    // final holidayController = TextEditingController(text: acquaintance.holiday);
    final occupationController =
        TextEditingController(text: acquaintance.occupation);
    final memoController = TextEditingController(text: acquaintance.memo);

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
                    await acquaintanceProvider.set(
                        userId: userProvider!.uid,
                        acquaintance: AcquaintanceModel(
                            acquaintanceId: acquaintance.acquaintanceId,
                            name: nameController.text,
                            createdAt: acquaintance.createdAt,
                            age: int.parse(ageController.text),
                            birthday: birthdayController.text,
                            birthplace: birthplaceController.text,
                            residence: residenceController.text,
                            holiday: 0,
                            occupation: occupationController.text,
                            memo: memoController.text,
                            icon: acquaintance.icon));
                    // AcquaintanceModel
                    // await acquaintanceProvider.set(
                    //     currentUser!.uid, acquaintance.acquaintanceId);
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
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: TextField(
              controller: nameController,
              cursorColor: Colors.black12,
              decoration: const InputDecoration(
                labelText: '名前',
                labelStyle: TextStyle(color: Colors.black),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                contentPadding:
                    EdgeInsets.only(left: 20, top: -10, bottom: 3, right: 10),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: TextField(
              controller: ageController,
              keyboardType: TextInputType.number,
              cursorColor: Colors.black12,
              decoration: const InputDecoration(
                labelText: '年齢',
                labelStyle: TextStyle(color: Colors.black),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                contentPadding:
                    EdgeInsets.only(left: 20, top: -10, bottom: 3, right: 10),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: TextField(
              readOnly: true,
              cursorColor: Colors.black12,
              decoration: InputDecoration(
                labelText: '生年月日',
                labelStyle: const TextStyle(color: Colors.black),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                contentPadding: const EdgeInsets.only(
                    left: 20, top: -10, bottom: 3, right: 20),
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
                                    onPressed: () => Navigator.pop(context),
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
                                      // initialDateTime: acquaintance.birthday,
                                      onDateTimeChanged: (value) {},
                                      // onDateTimeChanged:
                                      //     (DateTime newDateTime) {
                                      //   changedAcquaintanceBirthdayProvider
                                      //           .text =
                                      //       DateFormat('yyyy年M月d日')
                                      //           .format(newDateTime);
                                      // },
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: TextField(
              controller: birthplaceController,
              cursorColor: Colors.black12,
              decoration: const InputDecoration(
                labelText: '出身地',
                labelStyle: TextStyle(color: Colors.black),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                contentPadding:
                    EdgeInsets.only(left: 20, top: -10, bottom: 3, right: 10),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: TextField(
              controller: residenceController,
              cursorColor: Colors.black12,
              decoration: const InputDecoration(
                labelText: '居住地',
                labelStyle: TextStyle(color: Colors.black),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                contentPadding:
                    EdgeInsets.only(left: 20, top: -10, bottom: 3, right: 10),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue)),
              ),
            ),
          ),
          // const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: TextField(
              controller: occupationController,
              cursorColor: Colors.black12,
              decoration: const InputDecoration(
                labelText: '職種',
                labelStyle: TextStyle(color: Colors.black),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                contentPadding:
                    EdgeInsets.only(left: 20, top: -10, bottom: 3, right: 10),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: TextField(
              controller: memoController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: const InputDecoration(
                hintText: 'メモ',
                labelStyle: TextStyle(color: Colors.black),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                contentPadding:
                    EdgeInsets.only(left: 20, top: -10, bottom: 3, right: 10),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue)),
              ),
            ),
          ),

          const SizedBox(height: 100),
        ]),
      ),
    );
  }
}
