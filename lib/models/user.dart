import 'dart:collection';

import 'package:flutter/material.dart';

class User {
  final int uid;
  final String name;
  final String? wayOfReading;
  final String? birthday;
  final String? image;

  const User.create({
    required this.name,
    this.wayOfReading,
    this.birthday,
    this.image,
  }) : uid = 0;
}

class UserRepository {
  UserRepository._();
  static UserRepository instance = UserRepository._();

  final List<User> _userList = [
    const User.create(
        name: '山本　太郎',
        wayOfReading: 'やまもと　たろう',
        birthday: '2000/10/03',
        image:
            "https://gws-ug.jp/wp-content/plugins/all-in-one-seo-pack/images/default-user-image.png"),
    const User.create(
        name: '佐藤　太郎',
        wayOfReading: 'さとう　たろう',
        birthday: '2000/12/23',
        image:
            "https://gws-ug.jp/wp-content/plugins/all-in-one-seo-pack/images/default-user-image.png"),
    const User.create(
        name: '近藤　太郎',
        wayOfReading: 'こんどう　たろう',
        birthday: '2000/05/12',
        image:
            "https://gws-ug.jp/wp-content/plugins/all-in-one-seo-pack/images/default-user-image.png"),
    const User.create(
        name: '近藤　太郎',
        wayOfReading: 'こんどう　たろう',
        birthday: '2000/05/12',
        image:
            "https://gws-ug.jp/wp-content/plugins/all-in-one-seo-pack/images/default-user-image.png"),
    const User.create(
        name: '近藤　太郎',
        wayOfReading: 'こんどう　たろう',
        birthday: '2000/05/12',
        image:
            "https://gws-ug.jp/wp-content/plugins/all-in-one-seo-pack/images/default-user-image.png"),
    const User.create(
        name: '近藤　太郎',
        wayOfReading: 'こんどう　たろう',
        birthday: '2000/05/12',
        image:
            "https://gws-ug.jp/wp-content/plugins/all-in-one-seo-pack/images/default-user-image.png"),
    const User.create(
        name: '近藤　太郎',
        wayOfReading: 'こんどう　たろう',
        birthday: '2000/05/12',
        image:
            "https://gws-ug.jp/wp-content/plugins/all-in-one-seo-pack/images/default-user-image.png"),
    const User.create(
        name: '近藤　太郎',
        wayOfReading: 'こんどう　たろう',
        birthday: '2000/05/12',
        image:
            "https://gws-ug.jp/wp-content/plugins/all-in-one-seo-pack/images/default-user-image.png"),
    const User.create(
        name: '近藤　太郎',
        wayOfReading: 'こんどう　たろう',
        birthday: '2000/05/12',
        image:
            "https://gws-ug.jp/wp-content/plugins/all-in-one-seo-pack/images/default-user-image.png"),
    const User.create(
        name: '近藤　太郎',
        wayOfReading: 'こんどう　たろう',
        birthday: '2000/05/12',
        image:
            "https://gws-ug.jp/wp-content/plugins/all-in-one-seo-pack/images/default-user-image.png"),
    const User.create(
        name: '近藤　太郎',
        wayOfReading: 'こんどう　たろう',
        birthday: '2000/05/12',
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
