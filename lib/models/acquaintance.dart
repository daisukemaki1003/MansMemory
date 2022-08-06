import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants/keys.dart';

class AcquaintanceModel {
  final String acquaintanceId; // Acquaintance id
  final String name; // 名前
  final Timestamp createdAt; // 作成日
  final int age; // 年齢
  final String birthday; // 誕生日
  final String birthplace; // 出身地
  final String residence; // 居住地
  final int holiday; // 休日
  final String occupation; // 職業
  final String memo; // メモ

  final String icon;

  AcquaintanceModel({
    required this.acquaintanceId,
    required this.name,
    required this.createdAt,
    required this.age,
    required this.birthday,
    required this.birthplace,
    required this.residence,
    required this.holiday,
    required this.occupation,
    required this.memo,
    required this.icon,
  });
}

Map<String, String> userDataConvertedToJP = {
  NAME: '名前',
  FURIGANA: 'ふりがな',
  BIRTHDAY: '生年月日',
  HOBBY: '趣味',
  HOLIDAY: '休日',
  BIRTHPLACE: '出身地',
  RESIDENCE: '居住地',
  OCCUPATION: '職種',
};

/*
name: String length(<30),
age: int(<150),
holiday: int(<128),
occupation:String length(20),
residence: String length(20),
birthday: String length(20),
birthplace: String length(20),
memo: String length(<300),
icon:String length(*),
*/

int maxLengthOfName = 30;
int maxLengthOfAge = 3;
int maxLengthOfHoliday = 30;
int maxLengthOfOccupation = 10;
int maxLengthOfResidence = 10;
int maxLengthOfBirthplace = 10;
int maxLengthOfMemo = 300;
