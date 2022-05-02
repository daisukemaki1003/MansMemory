import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mans_memory/provider/user_provider.dart';

class UserDetailsScreen extends ConsumerWidget {
  const UserDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('maki')),
      body: Column(
        children: [
          // User info
          Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 20.0),
            child: Row(
              children: [
                // User image
                Column(
                  children: [
                    CircleAvatar(
                      radius: 45,
                      backgroundImage: const NetworkImage(
                          "https://gws-ug.jp/wp-content/plugins/all-in-one-seo-pack/images/default-user-image.png"),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Stack(
                          alignment: Alignment.center,
                          children: const [
                            CircleAvatar(
                              radius: 10,
                              backgroundColor: Colors.white,
                            ),
                            CircleAvatar(
                              radius: 8,
                              backgroundColor: Colors.blue,
                            ),
                            Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 14,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 20),
                // User name
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "maki",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 27,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "2000/10/03",
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ],
            ),
          ),

          TextButton(
            style: TextButton.styleFrom(
              side: const BorderSide(
                color: Colors.black12, //色
                width: 1.5, //太さ
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                "プロフィールを編集",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
