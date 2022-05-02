import 'dart:collection';

import 'package:flutter/material.dart';

class User {
  final int uid;
  final String name;
  final String? wayOfReading;
  final String? birthday;
  final String? image;

  // const User({
  //   required this.wayOfReading,
  //   required this.birthday,
  //   required this.image,
  //   required this.uid,
  //   required this.name,
  // });

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
        name: '牧　大佑',
        wayOfReading: 'まき　だいすけ',
        birthday: '2000/10/03',
        image:
            'https://zukan.pokemon.co.jp/zukan-api/up/images/index/8ea8bf2182acb6d1a000909a5b90f74b.png'),
    const User.create(
        name: '芝辻　大輝',
        wayOfReading: 'しばつじ　たいき',
        birthday: '2000/12/23',
        image:
            'https://coconutsjapan.com/wp-content/uploads/2021/05/jiji_anthony_matenro.jpg'),
    const User.create(
        name: '近藤　祐介',
        wayOfReading: 'こんどう　ゆうすけ',
        birthday: '2000/05/12',
        image:
            'https://booth.pximg.net/2458bc40-5ac8-434a-a59b-32d33771cba3/i/1768071/74062995-425f-4e14-9599-f4913337eb8e_base_resized.jpg'),
    const User.create(
        name: '近藤　祐介',
        wayOfReading: 'こんどう　ゆうすけ',
        birthday: '2000/05/12',
        image:
            'https://booth.pximg.net/2458bc40-5ac8-434a-a59b-32d33771cba3/i/1768071/74062995-425f-4e14-9599-f4913337eb8e_base_resized.jpg'),
    const User.create(
        name: '近藤　祐介',
        wayOfReading: 'こんどう　ゆうすけ',
        birthday: '2000/05/12',
        image:
            'https://booth.pximg.net/2458bc40-5ac8-434a-a59b-32d33771cba3/i/1768071/74062995-425f-4e14-9599-f4913337eb8e_base_resized.jpg'),
    const User.create(
        name: '近藤　祐介',
        wayOfReading: 'こんどう　ゆうすけ',
        birthday: '2000/05/12',
        image:
            'https://booth.pximg.net/2458bc40-5ac8-434a-a59b-32d33771cba3/i/1768071/74062995-425f-4e14-9599-f4913337eb8e_base_resized.jpg'),
    const User.create(
        name: '近藤　祐介',
        wayOfReading: 'こんどう　ゆうすけ',
        birthday: '2000/05/12',
        image:
            'https://booth.pximg.net/2458bc40-5ac8-434a-a59b-32d33771cba3/i/1768071/74062995-425f-4e14-9599-f4913337eb8e_base_resized.jpg'),
    const User.create(
        name: '近藤　祐介',
        wayOfReading: 'こんどう　ゆうすけ',
        birthday: '2000/05/12',
        image:
            'https://booth.pximg.net/2458bc40-5ac8-434a-a59b-32d33771cba3/i/1768071/74062995-425f-4e14-9599-f4913337eb8e_base_resized.jpg'),
    const User.create(
        name: '近藤　祐介',
        wayOfReading: 'こんどう　ゆうすけ',
        birthday: '2000/05/12',
        image:
            'https://booth.pximg.net/2458bc40-5ac8-434a-a59b-32d33771cba3/i/1768071/74062995-425f-4e14-9599-f4913337eb8e_base_resized.jpg'),
    const User.create(
        name: '近藤　祐介',
        wayOfReading: 'こんどう　ゆうすけ',
        birthday: '2000/05/12',
        image:
            'https://booth.pximg.net/2458bc40-5ac8-434a-a59b-32d33771cba3/i/1768071/74062995-425f-4e14-9599-f4913337eb8e_base_resized.jpg'),
    const User.create(
        name: '近藤　祐介',
        wayOfReading: 'こんどう　ゆうすけ',
        birthday: '2000/05/12',
        image:
            'https://booth.pximg.net/2458bc40-5ac8-434a-a59b-32d33771cba3/i/1768071/74062995-425f-4e14-9599-f4913337eb8e_base_resized.jpg'),
  ];

  Future<List<User>> fetchUserList() async {
    await Future<void>.delayed(const Duration(milliseconds: 1000));
    return _userList;
  }

  void add(User user) => _userList.add(user);
  void remove(User user) => _userList.remove(user);
}
