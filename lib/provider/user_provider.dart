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

    Color textFieldColor = const Color(0xFF000000);

    BuildContext mainContext = context; //これを追加
    final result = showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      builder: (BuildContext context) {
        return build(mainContext);
      },
    );

    if (result == true && name.isNotEmpty) {
      UserRepository.instance
          .add(User.create(name: name, wayOfReading: wayOfReading));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('[$name]を追加しました！'),
      ));
      notifyListeners();
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey, //色
                spreadRadius: 4,
                blurRadius: 4,
                offset: Offset(1, 1),
              ),
            ],
          ),
          padding: const EdgeInsets.only(top: 50.0),
          child: AppBar(
            title: const Text(
              "ユーザー作成",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            elevation: 0,
            actions: [
              TextButton(
                onPressed: () {},
                child: const Text(
                  "保存",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              color: Colors.grey,
            ),
            inputField('名前'),
            inputField('ふりがな'),
            inputField('年齢'),
            inputField('生年月日'),
            SizedBox(height: 40),
            inputField('趣味'),
            inputField('居住地'),
            inputField('休日'),
            SizedBox(height: 40),
            inputField('学歴'),
            inputField('職種'),
            inputField('年収'),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Container inputField(String text) {
    return Container(
      decoration: const BoxDecoration(
        border: Border.symmetric(horizontal: BorderSide(width: 0.2)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: TextField(
          autofocus: true,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            border: InputBorder.none,
            prefixIcon: SizedBox(
                width: 90,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Text(text,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                )),
            hintText: text,
          ),
        ),
      ),
    );
  }
}
