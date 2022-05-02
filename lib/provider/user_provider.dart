import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';

final usersProvider =
    ChangeNotifierProvider<UsersController>((ref) => UsersController._());

class UsersController extends ChangeNotifier {
  UsersController._();

  Future<List<User>> fetchUserList() async {
    return UserRepository.instance.fetchUserList();
  }

  Future<void> addUser(BuildContext context) async {
    var name = '';
    var wayOfReading = '';

    final result = await showDialog<bool?>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("ユーザーを登録"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                // controller: nameController,
                autofocus: true,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  hintText: '名前',
                ),
                onChanged: (value) => name = value,
              ),
              TextField(
                // controller: wayOfReadingController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  hintText: 'ふりがな',
                ),
                onChanged: (value) => wayOfReading = value,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('キャンセル'),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            TextButton(
              child: const Text('追加'),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        );
      },
    );
    if (result == true && name.isNotEmpty) {
      UserRepository.instance.add(User.create(name: name, wayOfReading: wayOfReading));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('[$name]を追加しました！'),
      ));
      notifyListeners();
    }
  }
}
