import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mans_memory/provider/user_provider.dart';

import '../../models/user.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(usersProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
        title: const Text("Man's memory"),
        centerTitle: true,
        // titleSpacing: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.sort),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          ),
          SizedBox(width: 5),
        ],
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: users.fetchUserList(),
          builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
            if (!snapshot.hasData) {
              return Text("no data");
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
                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 32.0,
                          vertical: 3.0,
                        ),
                        leading: CircleAvatar(
                          radius: 25,
                          child: ClipOval(
                            child: Image.network(user.image),
                          ),
                        ),
                        title: Text(user.name),
                        subtitle: Text(user.wayOfReading),
                        trailing: Text(user.birthday),
                        onTap: () {},
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
}
