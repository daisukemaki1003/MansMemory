import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mans_memory/models/user.dart';

class EditUser extends ChangeNotifier {
  final User user;
  EditUser(this.user) {
    nameController.text = user.name;
    furiganaController.text = user.furigana ?? '';
    birthdayController.text = user.birthday != null
        ? DateFormat('yyyy年M月d日').format(user.birthday!)
        : '';
    birthplaceController.text = user.birthplace ?? '';
    residenceController.text = user.residence ?? '';
    educationalBackgroundController.text = user.educationalBackground ?? '';
    occupationController.text = user.occupation ?? '';
    annualIncomeController.text = user.annualIncome.toString();
  }
  final nameController = TextEditingController();
  final furiganaController = TextEditingController();
  final birthdayController = TextEditingController();
  final birthplaceController = TextEditingController();
  final residenceController = TextEditingController();
  final educationalBackgroundController = TextEditingController();
  final occupationController = TextEditingController();
  final annualIncomeController = TextEditingController();
  // final imageController = TextEditingController();
  // final hobbyController = TextEditingController();
  // final holidayController = TextEditingController();

  late String name;
  String? furigana;
  DateTime? birthday;

  String? birthplace;
  String? residence;
  // List<dynamic>? hobby;
  // List<dynamic>? holiday;

  String? educationalBackground;
  String? occupation;
  int? annualIncome;

  void setName(String name) {
    this.name = name;
    notifyListeners();
  }

  void setFurigana(String furigana) {
    this.furigana = furigana;
    notifyListeners();
  }

  // void setBirthday(String birthday) {
  //   this.birthday = DateTime.parse(
  //     birthday
  //         .replaceFirst('年', '-')
  //         .replaceFirst('月', '-')
  //         .replaceFirst('日', ''),
  //   );
  //   notifyListeners();
  // }
  void setBirthday(DateTime birthday) {
    this.birthday = birthday;
    notifyListeners();
  }

  void setBirthplace(String birthplace) {
    this.birthplace = birthplace;
    notifyListeners();
  }

  void setResidence(String residence) {
    this.residence = residence;
    notifyListeners();
  }

  void setEducationalBackground(String educationalBackground) {
    this.educationalBackground = educationalBackground;
    notifyListeners();
  }

  void setOccupation(String occupation) {
    this.occupation = occupation;
    notifyListeners();
  }

  void setAnnualIncome(String annualIncome) {
    this.annualIncome = int.parse(annualIncome);
    notifyListeners();
  }
}
