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
import 'package:flutter/material.dart';

class User {
  final String uid;

  final String name;
  final String? furigana;
  final int? age;
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
    required this.age,
    required this.hobby,
    required this.residence,
    required this.holiday,
    required this.educationalBackground,
    required this.occupation,
    required this.annualIncome,
  });
}

class UserTextEditingController {
  Map<String, TextEditingController> basicInformationController = {
    '名前': TextEditingController(),
    'ふりがな': TextEditingController(),
    '年齢': TextEditingController(),
    '生年月日': TextEditingController()
  };

  Map<String, TextEditingController> hobbiesAndLifeController = {
    '趣味': TextEditingController(),
    '出身地': TextEditingController(),
    '居住地': TextEditingController(),
    '休日': TextEditingController()
  };

  Map<String, TextEditingController>
      educationalBackgroundAndOccupationController = {
    '学歴': TextEditingController(),
    '職種': TextEditingController(),
    '年収': TextEditingController(),
  };
}

