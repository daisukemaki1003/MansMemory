import 'package:flutter/material.dart';

import '../../../models/user.dart';

// Padding nameInputField(User user) {
//   TextEditingController controller = TextEditingController();
//   return Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//     child: TextField(
//       controller: controller,
//       cursorColor: Colors.black12,
//       onChanged: (value) => user.updateName = controller.text,
//       decoration: InputDecoration(
//         labelText: '名前',
//         labelStyle: const TextStyle(color: Colors.black),
//         floatingLabelBehavior: FloatingLabelBehavior.always,
//         contentPadding:
//             const EdgeInsets.only(left: 20, top: 0, bottom: 3, right: 10),
//         focusedBorder: const UnderlineInputBorder(
//             borderSide: BorderSide(color: Colors.blue)),
//         suffix: IconButton(
//           icon: const Icon(Icons.clear, color: Colors.black54),
//           onPressed: () {
//             controller.clear();
//           },
//         ),
//       ),
//     ),
//   );
// }
