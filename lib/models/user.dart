import 'dart:collection';

import 'package:flutter/material.dart';

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
class User {
  final int uid;
  final String? image;

  final String name;
  final String? wayOfReading;
  final int? age;
  final DateTime? birthday;

  final List<String>? hobby;
  final String? residence;
  final List<int>? holiday;

  final String? educationalBackground;
  final String? occupation;
  final int? annualIncome;

  final String? memo;

  const User.create({
    required this.name,
    this.wayOfReading,
    this.birthday,
    this.image,
    this.age,
    this.hobby,
    this.residence,
    this.holiday,
    this.educationalBackground,
    this.occupation,
    this.annualIncome,
    this.memo,
  }) : uid = 0;
}

class UserRepository {
  UserRepository._();
  static UserRepository instance = UserRepository._();

  final List<User> _userList = [
    User.create(
        name: '山本　太郎',
        wayOfReading: 'やまもと　たろう',
        birthday: DateTime(2020, 10, 2),
        image:
            "https://gws-ug.jp/wp-content/plugins/all-in-one-seo-pack/images/default-user-image.png"),
    User.create(
        name: '佐藤　太郎',
        wayOfReading: 'さとう　たろう',
        birthday: DateTime(2020, 10, 2),
        image:
            "https://gws-ug.jp/wp-content/plugins/all-in-one-seo-pack/images/default-user-image.png"),
    User.create(
        name: '近藤　太郎',
        wayOfReading: 'こんどう　たろう',
        birthday: DateTime(2020, 10, 2),
        image:
            "https://gws-ug.jp/wp-content/plugins/all-in-one-seo-pack/images/default-user-image.png"),
    User.create(
        name: '近藤　太郎',
        wayOfReading: 'こんどう　たろう',
        birthday: DateTime(2020, 10, 2),
        image:
            "https://gws-ug.jp/wp-content/plugins/all-in-one-seo-pack/images/default-user-image.png"),
    User.create(
        name: '近藤　太郎',
        wayOfReading: 'こんどう　たろう',
        birthday: DateTime(2020, 10, 2),
        image:
            "https://gws-ug.jp/wp-content/plugins/all-in-one-seo-pack/images/default-user-image.png"),
    User.create(
        name: '近藤　太郎',
        wayOfReading: 'こんどう　たろう',
        birthday: DateTime(2020, 10, 2),
        image:
            "https://gws-ug.jp/wp-content/plugins/all-in-one-seo-pack/images/default-user-image.png"),
    User.create(
        name: '近藤　太郎',
        wayOfReading: 'こんどう　たろう',
        birthday: DateTime(2020, 10, 2),
        image:
            "https://gws-ug.jp/wp-content/plugins/all-in-one-seo-pack/images/default-user-image.png"),
    User.create(
        name: '近藤　太郎',
        wayOfReading: 'こんどう　たろう',
        birthday: DateTime(2020, 10, 2),
        image:
            "https://gws-ug.jp/wp-content/plugins/all-in-one-seo-pack/images/default-user-image.png"),
    User.create(
        name: '近藤　太郎',
        wayOfReading: 'こんどう　たろう',
        birthday: DateTime(2020, 10, 2),
        image:
            "https://gws-ug.jp/wp-content/plugins/all-in-one-seo-pack/images/default-user-image.png"),
    User.create(
        name: '近藤　太郎',
        wayOfReading: 'こんどう　たろう',
        birthday: DateTime(2020, 10, 2),
        image:
            "https://gws-ug.jp/wp-content/plugins/all-in-one-seo-pack/images/default-user-image.png"),
    User.create(
        name: '近藤　太郎',
        wayOfReading: 'こんどう　たろう',
        birthday: DateTime(2020, 10, 2),
        image:
            "https://gws-ug.jp/wp-content/plugins/all-in-one-seo-pack/images/default-user-image.png"),
  ];

  Future<List<User>> fetchUserList() async {
    await Future<void>.delayed(const Duration(milliseconds: 1000));
    return _userList;
  }

  void add(User user) => _userList.add(user);
  void remove(User user) => _userList.remove(user);
}
