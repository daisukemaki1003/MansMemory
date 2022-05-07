import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mans_memory/models/user.dart';
import 'package:mans_memory/provider/navigator_provider.dart';
import 'package:mans_memory/provider/user_provider.dart';

class UserListScreen extends ConsumerWidget {
  const UserListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(usersProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
        title: const Text("Title"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                ),
                builder: (BuildContext context) {
                  return userRegistrationDialog(users);
                },
              );
            },
          ),
          const SizedBox(width: 5),
        ],
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: users.fetch(),
          builder: (context, AsyncSnapshot<List<User>> snapshot) {
            if (!snapshot.hasData) {
              return const Text("no data");
            }
            final userList = snapshot.data!;
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: const ScrollPhysics(),
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: userList.length,
                    itemBuilder: (context, index) {
                      final user = userList[index];
                      return Dismissible(
                        key: Key(user.name),
                        background: Container(
                          padding: const EdgeInsets.only(
                            right: 10,
                          ),
                          alignment: AlignmentDirectional.centerEnd,
                          color: Colors.red,
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) => userList.remove(user),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 32.0,
                            vertical: 3.0,
                          ),
                          leading: CircleAvatar(
                            radius: 25,
                            child: ClipOval(
                              child: Image.network(user.image ??
                                  "https://gws-ug.jp/wp-content/plugins/all-in-one-seo-pack/images/default-user-image.png"),
                            ),
                          ),
                          title: Text(user.name),
                          subtitle: Text(user.furigana ?? ""),
                          trailing: user.birthday != null
                              ? Text(DateFormat('yyyy年M月d日')
                                  .format(user.birthday!))
                              : const Text(""),
                          onTap: () => ref.read(pageProvider.state).state = 1,
                        ),
                      );
                    },
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget userRegistrationDialog(UserRepository users) {
    UserTextEditingController controller = UserTextEditingController();
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
                onPressed: () => users.add(controller),
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
        child: Column(children: inputFieldList(controller)),
      ),
    );
  }

  List<Widget> inputFieldList(UserTextEditingController controllers) {
    List<Widget> widgetsList = [];
    widgetsList.add(Container(
      height: 200,
      width: double.infinity,
      color: Colors.grey,
    ));
    controllers.basicInformationController.forEach((key, value) {
      widgetsList.add(inputField(key, value));
    });
    widgetsList.add(const SizedBox(height: 40));
    controllers.hobbiesAndLifeController.forEach((key, value) {
      widgetsList.add(inputField(key, value));
    });
    widgetsList.add(const SizedBox(height: 40));
    controllers.educationalBackgroundAndOccupationController
        .forEach((key, value) {
      widgetsList.add(inputField(key, value));
    });
    widgetsList.add(const SizedBox(height: 50));
    return widgetsList;
  }

  Container inputField(String text, TextEditingController controller) {
    return Container(
      decoration: const BoxDecoration(
        border: Border.symmetric(horizontal: BorderSide(width: 0.2)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: TextField(
          controller: controller,
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
