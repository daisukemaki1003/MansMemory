/*
基本情報
  名前
  ふりがな
  年齢
  生年月日
趣味、生活
  趣味
  居住地
  休日
学歴、職種
  学歴
  職種
  年収 
*/
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class User {
  final String uid;

  final String name;
  final String? furigana;
  final DateTime? birthday;

  final String? birthplace;
  final String? residence;
  final List<dynamic>? hobby;
  final List<dynamic>? holiday;

  final String? educationalBackground;
  final String? occupation;
  final int? annualIncome;

  final String? image;

  User({
    required this.uid,
    required this.name,
    required this.furigana,
    required this.birthday,
    required this.birthplace,
    required this.image,
    required this.hobby,
    required this.residence,
    required this.holiday,
    required this.educationalBackground,
    required this.occupation,
    required this.annualIncome,
  });
}

class UserDataTable {
  Map<String, TextEditingController> table1 = {
    'name': TextEditingController(),
    'furigana': TextEditingController(),
    'birthday': TextEditingController(),
  };

  Map<String, TextEditingController> table2 = {
    'hobby': TextEditingController(),
    'holiday': TextEditingController(),
    'birthplace': TextEditingController(),
    'residence': TextEditingController(),
  };

  Map<String, TextEditingController> table3 = {
    'educational_background': TextEditingController(),
    'occupation': TextEditingController(),
    'annual_income': TextEditingController(),
  };
  // Map<String, dynamic> convertToCorrespondingData() {
  //   Map<String, dynamic> data = {};
  //   table.forEach((key, value) {
  //     data[key] = value.value;
  //   });
  //   return data;
  // }
}

// Map<String, TextEditingController> userTextEditingControllerTable = {
//   'name': TextEditingController(),
//   'furigana': TextEditingController(),
//   'age': TextEditingController(),
//   'birthday': TextEditingController(),
//   'hobby': TextEditingController(),
//   'holiday': TextEditingController(),
//   'birthplace': TextEditingController(),
//   'residence': TextEditingController(),
//   'educational_background': TextEditingController(),
//   'occupation': TextEditingController(),
//   'annual_income': TextEditingController(),
// };

Map<String, String> userDataConvertedToJapanese = {
  'name': '名前',
  'furigana': 'ふりがな',
  'birthday': '生年月日',
  'hobby': '趣味',
  'holiday': '休日',
  'birthplace': '出身地',
  'residence': '居住地',
  'educational_background': '学歴',
  'occupation': '職種',
  'annual_income': '年収',
};

// Map<String, dynamic> userDataKeyCompatibilityTableInType = {
//   'name': String,
//   'furigana': String,
//   'age': int,
//   'birthday': Timestamp,
//   'hobby': List<String>,
//   'holiday': List<bool>,
//   'birthplace': String,
//   'residence': String,
//   'educational_background': String,
//   'occupation': String,
//   'annual_income': int,
// };
