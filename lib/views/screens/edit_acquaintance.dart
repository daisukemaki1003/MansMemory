import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mans_memory/provider/acquaintance.dart';

import '../../models/acquaintance.dart';
import '../../models/acquaintance_holiday.dart';
import '../../provider/authentication.dart';

class AcquaintanceEditScreen extends ConsumerStatefulWidget {
  const AcquaintanceEditScreen({Key? key, required this.acquaintance})
      : super(key: key);
  final AcquaintanceModel acquaintance;

  @override
  _AcquaintanceEditScreenState createState() => _AcquaintanceEditScreenState();
}

class _AcquaintanceEditScreenState
    extends ConsumerState<AcquaintanceEditScreen> {
  var month = 1;
  var day = 1;

  List<holidayCheckboxData> holidayList = [];

  // TextEditingController作成
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final birthdayController = TextEditingController();
  final birthplaceController = TextEditingController();
  final residenceController = TextEditingController();
  final holidayController = TextEditingController();
  final occupationController = TextEditingController();
  final memoController = TextEditingController();

  @override
  void initState() {
    // Binary(Holiday data)変換
    holidayList = convertHolidayDataIntoBinary(widget.acquaintance.holiday);
    print(widget.acquaintance.holiday);

    // TextEditingController初期化
    nameController.text = widget.acquaintance.name;
    ageController.text =
        widget.acquaintance.age > 0 ? widget.acquaintance.age.toString() : '';
    birthdayController.text = widget.acquaintance.birthday;
    birthplaceController.text = widget.acquaintance.birthplace;
    residenceController.text = widget.acquaintance.residence;
    occupationController.text = widget.acquaintance.occupation;
    memoController.text = widget.acquaintance.memo;

    for (var item in holidayList) {
      if (item.checked) {
        holidayController.text += item.getDisplayText() + ',';
      }
    }
    if (holidayController.text.isNotEmpty) {
      holidayController.text = holidayController.text
          .substring(0, holidayController.text.length - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = ref.watch(currentUserProvider);
    final acquaintanceProvider = ref.watch(acquaintanceStateProvider);

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
                    // 休日バイナリ変換
                    String holiday = '';
                    for (var item in holidayList.reversed) {
                      item.checked ? holiday += '1' : holiday += '0';
                    }

                    await acquaintanceProvider.set(
                        userId: userProvider!.uid,
                        acquaintance: AcquaintanceModel(
                            acquaintanceId: widget.acquaintance.acquaintanceId,
                            name: nameController.text,
                            createdAt: widget.acquaintance.createdAt,
                            age: ageController.text.isNotEmpty
                                ? int.parse(ageController.text)
                                : 0,
                            birthday: birthdayController.text,
                            birthplace: birthplaceController.text,
                            residence: residenceController.text,
                            holiday: int.parse(holiday, radix: 2),
                            occupation: occupationController.text,
                            memo: memoController.text,
                            icon: widget.acquaintance.icon));
                    Navigator.pop(context);
                  } catch (e) {
                    print(e.toString());
                    final snackBar = SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(e.toString()),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
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
              maxLength: maxLengthOfName,
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
              maxLength: maxLengthOfAge,
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
                controller: birthdayController,
                readOnly: true,
                cursorColor: Colors.black12,
                decoration: const InputDecoration(
                  labelText: '生年月日',
                  labelStyle: TextStyle(color: Colors.black),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  contentPadding:
                      EdgeInsets.only(left: 20, top: -10, bottom: 3, right: 20),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue)),
                ),
                onTap: () async {
                  final result = await _datePicker(context);
                  if (result != null && result) {
                    birthdayController.text =
                        month.toString() + '/' + day.toString();
                    print(birthdayController.text);
                  }
                }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: TextField(
              controller: birthplaceController,
              maxLength: maxLengthOfBirthplace,
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
              maxLength: maxLengthOfResidence,
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
              maxLength: maxLengthOfOccupation,
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
              controller: holidayController,
              readOnly: true,
              cursorColor: Colors.black12,
              decoration: const InputDecoration(
                labelText: '休日',
                labelStyle: TextStyle(color: Colors.black),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                contentPadding:
                    EdgeInsets.only(left: 20, top: -10, bottom: 3, right: 10),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue)),
              ),
              onTap: () async {
                final result = await _holidaySelectionCheckbox(context);
                if (result != null && result) {
                  holidayController.text = '';
                  for (var item in holidayList) {
                    if (item.checked) {
                      holidayController.text += item.getDisplayText() + ',';
                    }
                  }
                  if (holidayController.text.isNotEmpty) {
                    holidayController.text = holidayController.text
                        .substring(0, holidayController.text.length - 1);
                  }
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: TextField(
              controller: memoController,
              maxLength: maxLengthOfMemo,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: const InputDecoration(
                labelText: 'メモ',
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

  Widget _saveDateButton(BuildContext context, String text, bool saveOr) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextButton(
        onPressed: () => Navigator.of(context).pop(saveOr),
        child: Text(text,
            style: const TextStyle(
                color: Colors.lightBlue, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _datePickerItems(int itemNum, String text, bool dateType) {
    return CupertinoPicker(
      itemExtent: 40,
      children: [
        for (int i = 1; i < itemNum; i++)
          Text(i.toString() + text, style: const TextStyle(fontSize: 20))
      ],
      onSelectedItemChanged: ((value) {
        if (dateType) {
          month = value + 1;
        } else {
          day = value + 1;
        }
      }),
    );
  }

  Future<bool?> _datePicker(BuildContext context) async {
    return await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height / 3,
          child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _saveDateButton(context, 'キャンセル', false),
                        _saveDateButton(context, '保存', true),
                      ],
                    ),
                  ),
                  const Divider(height: 1, thickness: 1, color: Colors.black26),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: _datePickerItems(13, '月', true)),
                        Expanded(child: _datePickerItems(32, '日', false)),
                      ],
                    ),
                  ),
                ],
              )),
        );
      },
    );
  }

  Future<bool?> _holidaySelectionCheckbox(BuildContext context) async {
    return await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 500,
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _saveDateButton(context, 'キャンセル', false),
                        _saveDateButton(context, '保存', true),
                      ],
                    ),
                  ),
                  const Divider(height: 1, thickness: 1, color: Colors.black26),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: holidayList.map<Widget>(
                      (data) {
                        print(data);
                        return SizedBox(
                          height: 60,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              CheckboxListTile(
                                value: data.checked,
                                title: Text(data.getDisplayText() + '曜日'),
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                onChanged: (bool? val) {
                                  state(() => data.checked = !data.checked);
                                },
                                activeColor: Colors.lightBlue,
                                checkColor: Colors.white,
                              ),
                            ],
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
