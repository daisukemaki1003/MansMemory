// static import 'package:flutter/material.dart';

// Future<String> select_icon(BuildContext context) async{

//   static const String SELECT_ICON = "アイコンを選択";
//   static const List<String> SELECT_ICON_OPTIONS = 
//     ["写真から選択", "写真を撮影"];
//   static const int GALLERY = 0;
//   static const int CAMERA = 1;
  
//   var _select_type=await showDialog(
//       context: context,
//       builder: (BuildContext context){
//         return SimpleDialog(
//           title: Text(SELECT_ICON),
//           children: SELECT_ICON_OPTIONS.asMap().entries.map((e) {
//             return SimpleDialogOption(
//               child: ListTile(
//                 title: Text(e.value),
//               ),
//               onPressed: ()=>Navigator.of(context).pop(e.key),
//             );
//           }).toList(),
//         ) ;
//       });

//   final picker=ImagePicker();
//   var  _img_src;

//   if (_select_type==null){
//     return null;
//   }
//   //カメラで撮影
//   else if (_select_type==CAMERA){
//     _img_src=ImageSource.camera;
//   }
//   //ギャラリーから選択
//   else if (_select_type==GALLERY){
//     _img_src=ImageSource.gallery;
//   }

//   final pickedFile = await picker.getImage(source: _img_src);

//   if (pickedFile==null){
//     return null;
//   }
//   else{
//     return pickedFile.path;
//   }
// }