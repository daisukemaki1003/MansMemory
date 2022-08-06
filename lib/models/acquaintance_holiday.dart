class holidayCheckboxData {
  int displayId;
  bool checked;

  holidayCheckboxData({
    required this.displayId,
    required this.checked,
  });

  String getDisplayText() {
    return displayTextList[displayId];
  }
}

// Binary(Holiday data)変換
List<holidayCheckboxData> convertHolidayDataIntoBinary(int holidayNum) {
  List<holidayCheckboxData> holidayList = [];
  String holidayBinary = holidayNum.toRadixString(2);
  List<String> holidayBinaryList = holidayBinary.padLeft(7, '0').split('');

  for (int i = 0; i < holidayBinaryList.length; i++) {
    holidayList.add(holidayCheckboxData(
        displayId: i,
        checked: int.parse(holidayBinaryList[i]) != 0 ? true : false));
  }
  return holidayList;
}

// バイナリ変換した休日データに応じた曜日データ(String)を取得
String getHolidayText(int holidayNum) {
  String buf = '';
  List<holidayCheckboxData> holidayList =
      convertHolidayDataIntoBinary(holidayNum);

  for (var item in holidayList) {
    if (item.checked) {
      buf += item.getDisplayText() + ',';
    }
  }
  if (buf.isNotEmpty) {
    buf = buf.substring(0, buf.length - 1);
  }
  return buf;
}

List displayTextList = ['月', '火', '水', '木', '金', '土', '日'];
