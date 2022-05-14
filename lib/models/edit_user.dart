import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mans_memory/models/user.dart';

class EditUser extends ChangeNotifier {
  final User user;
  EditUser(this.user) {
    setName(user.name);
    nameController.text = user.name;

    setFurigana(user.furigana ?? '');
    furiganaController.text = user.furigana ?? '';

    if (user.birthday != null) {
      setBirthday(user.birthday!);
      birthdayController.text = DateFormat('yyyy年M月d日').format(user.birthday!);
    }

    setBirthplace(user.birthplace ?? '');
    birthplaceController.text = user.birthplace ?? '';

    setResidence(user.residence ?? '');
    residenceController.text = user.residence ?? '';

    setEducationalBackground(user.educationalBackground ?? '');
    educationalBackgroundController.text = user.educationalBackground ?? '';

    setOccupation(user.occupation ?? '');
    occupationController.text = user.occupation ?? '';

    if (user.annualIncome != null) {
      setAnnualIncome(user.annualIncome.toString());
      annualIncomeController.text = user.annualIncome.toString();
    }
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

  String? name;
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
  }

  void setFurigana(String furigana) {
    this.furigana = furigana;
  }

  // void setBirthday(String birthday) {
  //   this.birthday = DateTime.parse(
  //     birthday
  //         .replaceFirst('年', '-')
  //         .replaceFirst('月', '-')
  //         .replaceFirst('日', ''),
  //   );
  // }
  void setBirthday(DateTime birthday) {
    this.birthday = birthday;
  }

  void setBirthplace(String birthplace) {
    this.birthplace = birthplace;
  }

  void setResidence(String residence) {
    this.residence = residence;
  }

  void setEducationalBackground(String educationalBackground) {
    this.educationalBackground = educationalBackground;
  }

  void setOccupation(String occupation) {
    this.occupation = occupation;
  }

  void setAnnualIncome(String annualIncome) {
    this.annualIncome = int.parse(annualIncome);
  }
}
