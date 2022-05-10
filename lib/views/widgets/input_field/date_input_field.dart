import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Container dateInputField(BuildContext context, String text) {
  TextEditingController datetimeController = TextEditingController();
  return Container(
    decoration: const BoxDecoration(
      border: Border.symmetric(horizontal: BorderSide(width: 0.1)),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: datetimeController,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          border: InputBorder.none,
          prefixIcon: SizedBox(
              width: 90,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Text(text,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              )),
          hintText: text,
        ),
        onTap: () => dateInputPopup(context),
      ),
    ),
  );
}

Future<void> dateInputPopup(
  BuildContext context,
) {
  var _dateTime = DateTime.now();

  return showCupertinoModalPopup<void>(
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CupertinoButton(
                  child: const Text(
                    'キャンセル',
                    style: TextStyle(color: Colors.blue),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
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
          _bottomPicker(
            CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: _dateTime,
              onDateTimeChanged: (DateTime newDateTime) {
                // datetimeController.text =
                //     DateFormat('yyyy年M月d日').format(newDateTime);
                // controller.text = newDateTime.toString();
              },
            ),
          )
        ],
      );
    },
  );
}

// datePickerの表示構成
Widget _bottomPicker(Widget picker) {
  return Container(
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
          child: picker,
        ),
      ),
    ),
  );
}
