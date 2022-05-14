import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Widget dateInputField(BuildContext context, String label, DateTime? data) {
//   TextEditingController controller = TextEditingController();

//   return Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//     child: TextField(
//       readOnly: true,
//       controller: controller,
//       cursorColor: Colors.black12,
//       decoration: InputDecoration(
//         labelText: label,
//         labelStyle: const TextStyle(color: Colors.black),
//         floatingLabelBehavior: FloatingLabelBehavior.always,
//         contentPadding:
//             const EdgeInsets.only(left: 20, top: 0, bottom: 3, right: 20),
//         focusedBorder: const UnderlineInputBorder(
//             borderSide: BorderSide(color: Colors.blue)),
//         suffix: TextButton(
//           child: const Text(
//             '編集',
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 17,
//               color: Color.fromARGB(255, 92, 136, 169),
//             ),
//           ),
//           onPressed: () {
//             showCupertinoModalPopup<void>(
//               context: context,
//               builder: (BuildContext context) {
//                 return Column(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: <Widget>[
//                     Container(
//                       decoration: const BoxDecoration(
//                         color: Color(0xffffffff),
//                         border: Border(
//                           bottom: BorderSide(
//                             color: Color(0xff999999),
//                             width: 0.0,
//                           ),
//                         ),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: <Widget>[
//                           CupertinoButton(
//                             child: const Text(
//                               'キャンセル',
//                               style: TextStyle(color: Colors.blue),
//                             ),
//                             onPressed: () => Navigator.pop(context),
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 16.0,
//                               vertical: 5.0,
//                             ),
//                           ),
//                           CupertinoButton(
//                             child: const Text(
//                               '追加',
//                               style: TextStyle(color: Colors.blue),
//                             ),
//                             onPressed: () {
//                               Navigator.pop(context);
//                             },
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 16.0,
//                               vertical: 5.0,
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                     Container(
//                       height: 216,
//                       padding: const EdgeInsets.only(top: 6.0),
//                       color: CupertinoColors.white,
//                       child: DefaultTextStyle(
//                         style: const TextStyle(
//                           color: CupertinoColors.black,
//                           fontSize: 22.0,
//                         ),
//                         child: GestureDetector(
//                           onTap: () {},
//                           child: SafeArea(
//                             top: false,
//                             child: CupertinoDatePicker(
//                               mode: CupertinoDatePickerMode.date,
//                               initialDateTime: data,
//                               onDateTimeChanged: (DateTime newDateTime) {
//                                 controller.text =
//                                     DateFormat('yyyy年M月d日').format(newDateTime);
//                               },
//                             ),
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                 );
//               },
//             );
//           },
//         ),
//       ),
//     ),
//   );
// }

// Future<void> dateInputPopup(
//     BuildContext context, TextEditingController controller) {
//   var _dateTime = DateTime.now();
//   return showCupertinoModalPopup<void>(
//     context: context,
//     builder: (BuildContext context) {
//       return Column(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: <Widget>[
//           Container(
//             decoration: const BoxDecoration(
//               color: Color(0xffffffff),
//               border: Border(
//                 bottom: BorderSide(
//                   color: Color(0xff999999),
//                   width: 0.0,
//                 ),
//               ),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 CupertinoButton(
//                   child: const Text(
//                     'キャンセル',
//                     style: TextStyle(color: Colors.blue),
//                   ),
//                   onPressed: () => Navigator.pop(context),
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 16.0,
//                     vertical: 5.0,
//                   ),
//                 ),
//                 CupertinoButton(
//                   child: const Text(
//                     '追加',
//                     style: TextStyle(color: Colors.blue),
//                   ),
//                   onPressed: () {
//                     // controller.text = date;
//                     Navigator.pop(context);
//                   },
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 16.0,
//                     vertical: 5.0,
//                   ),
//                 )
//               ],
//             ),
//           ),
//           Container(
//             height: 216,
//             padding: const EdgeInsets.only(top: 6.0),
//             color: CupertinoColors.white,
//             child: DefaultTextStyle(
//               style: const TextStyle(
//                 color: CupertinoColors.black,
//                 fontSize: 22.0,
//               ),
//               child: GestureDetector(
//                 onTap: () {},
//                 child: SafeArea(
//                   top: false,
//                   child: CupertinoDatePicker(
//                     mode: CupertinoDatePickerMode.date,
//                     initialDateTime: _dateTime,
//                     onDateTimeChanged: (DateTime newDateTime) {
//                       // controller.text =
//                       // date = DateFormat('yyyy年M月d日').format(newDateTime);
//                     },
//                   ),
//                 ),
//               ),
//             ),
//           )
//         ],
//       );
//     },
//   );
// }
