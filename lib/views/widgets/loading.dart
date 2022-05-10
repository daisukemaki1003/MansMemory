import 'package:flutter/material.dart';

Widget loading() {
  return Container(
    alignment: Alignment.center,
    child: const SizedBox(
      height: 30,
      width: 30,
      child: CircularProgressIndicator(
        strokeWidth: 4.0,
        color: Color.fromARGB(255, 101, 186, 255),
      ),
    ),
  );
}
