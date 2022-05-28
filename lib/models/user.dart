
import '../constants/keys.dart';

class UserModel {
  
  final String uid;

  final String name;
  final String? furigana;
  final DateTime? birthday;

  final String? birthplace;
  final String? residence;
  // final List<dynamic>? hobby;
  // final List<dynamic>? holiday;

  final String? educationalBackground;
  final String? occupation;
  final int? annualIncome;

  final String? icon;

  UserModel({
    required this.uid,
    required this.name,
    required this.furigana,
    required this.birthday,
    required this.birthplace,
    required this.icon,
    // required this.hobby,
    // required this.holiday,
    required this.residence,
    required this.educationalBackground,
    required this.occupation,
    required this.annualIncome,
  });
}

Map<String, String> userDataConvertedToJP = {
  NAME: '名前',
  FURIGANA: 'ふりがな',
  BIRTHDAY: '生年月日',
  HOBBY: '趣味',
  HOLIDAY: '休日',
  BIRTHPLACE: '出身地',
  RESIDENCE: '居住地',
  EDUCATIONAL_BACKGROUND: '学歴',
  OCCUPATION: '職種',
  ANNUAL_INCOME: '年収',
};
