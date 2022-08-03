// import 'package:flutter/material.dart';

// import '../../models/acquaintance_holiday.dart';

// class HolidayEditWidget extends StatefulWidget {
//   const HolidayEditWidget({Key? key, required this.holiday}) : super(key: key);
//   final int holiday;

//   @override
//   State<HolidayEditWidget> createState() => _HolidayEditWidgetState();
// }

// class _HolidayEditWidgetState extends State<HolidayEditWidget> {
//   bool isChecked = false;
//   List<holidayCheckboxData> checkboxDataList = [];

//   @override
//   void initState() {
//     List<String> bitset = widget.holiday.toRadixString(2).split('');
//     for (int i = 0; i < bitset.length; i++) {
//       checkboxDataList.add(holidayCheckboxData(
//           id: '1',
//           displayId: i,
//           checked: int.parse(bitset[i]) != 0 ? true : false));
//     }
//   }

//   Future<void> build(BuildContext context) {
//      showModalBottomSheet(
//       context: context,
//       builder: (BuildContext context) {
//         return StatefulBuilder(
//           builder: (BuildContext context, StateSetter state) {
//             return SingleChildScrollView(
//               child: LimitedBox(
//                 maxHeight: checkboxDataList.length * 60 + 30,
//                 child: Column(
//                   mainAxisSize: MainAxisSize.max,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: checkboxDataList.map<Widget>(
//                     (data) {
//                       return Container(
//                         height: 60,
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: <Widget>[
//                             CheckboxListTile(
//                               value: data.checked,
//                               title: Text(data.getDisplayText()),
//                               controlAffinity: ListTileControlAffinity.leading,
//                               onChanged: (bool? val) {
//                                 state(() {
//                                   data.checked = !data.checked;
//                                 });
//                                 print(
//                                     widget.holiday.toRadixString(2).split(''));
//                               },
//                               activeColor: Colors.lightBlue,
//                               checkColor: Colors.white,
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ).toList(),
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }


  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //       home: Scaffold(
  //     appBar: AppBar(
  //       title: const Text('Flutter'),
  //     ),
  //     body: Center(
  //       child: TextButton(
  //         onPressed: () => _showModalSheet(),
  //         child: const Text("Button", style: TextStyle(color: Colors.black)),
  //       ),
  //     ),
  //   ));
  // }