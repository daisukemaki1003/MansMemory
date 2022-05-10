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

import '../constants/keys.dart';

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
  Map<String, TextEditingController> data = {
    NAME: TextEditingController(),
    FURIGANA: TextEditingController(),
    BIRTHDAY: TextEditingController(),
    HOBBY: TextEditingController(),
    HOLIDAY: TextEditingController(),
    BIRTHPLACE: TextEditingController(),
    RESIDENCE: TextEditingController(),
    EDUCATIONAL_BACKGROUND: TextEditingController(),
    OCCUPATION: TextEditingController(),
    ANNUAL_INCOME: TextEditingController(),
  };
}

Map<String, String> userDataConvertedToJP = {
  NAME: '名前',
  FURIGANA: 'ふりがな',
  BIRTHDAY: '生年月日',
  HOBBY: '趣味',
  HOLIDAY: '休日',
  BIRTHPLACE: '出身地',
  RESIDENCE: '居住地',
  EDUCATIONAL_BACKGROUND: '学歴',
  OCCUPATION: '職種',
  ANNUAL_INCOME: '年収',
};

Map<String, Type> userDataKeyCompatibilityTableInType = {
  NAME: String,
  FURIGANA: String,
  BIRTHDAY: Timestamp,
  HOBBY: List<String>,
  HOLIDAY: List<bool>,
  BIRTHPLACE: String,
  RESIDENCE: String,
  EDUCATIONAL_BACKGROUND: String,
  OCCUPATION: String,
  ANNUAL_INCOME: int,
  IMAGE: String,
};
