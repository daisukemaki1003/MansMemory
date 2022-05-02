import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';

final usersProvider =
    ChangeNotifierProvider<UsersProvider>((ref) => UsersProvider._());

class UsersProvider extends ChangeNotifier {
  UsersProvider._();

  Future<List<User>> fetchUserList() async {
    return UserRepository.instance.fetchUserList();
  }
}
