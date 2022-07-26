import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mans_memory/models/acquaintance.dart';

class EditAcquaintance extends ChangeNotifier {
  final AcquaintanceModel acquaintance;
  EditAcquaintance(this.acquaintance) {
    setName(acquaintance.name);
    nameController.text = acquaintance.name;

    if (acquaintance.birthday != null) {
      setBirthday(acquaintance.birthday!);
      birthdayController.text =
          DateFormat('yyyy年M月d日').format(acquaintance.birthday!);
    }

    setBirthplace(acquaintance.birthplace ?? '');
    birthplaceController.text = acquaintance.birthplace ?? '';

    setResidence(acquaintance.residence ?? '');
    residenceController.text = acquaintance.residence ?? '';

    setOccupation(acquaintance.occupation ?? '');
    occupationController.text = acquaintance.occupation ?? '';
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
