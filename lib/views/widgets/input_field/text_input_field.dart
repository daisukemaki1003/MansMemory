import 'package:flutter/material.dart';

Container textInputField(String text, TextEditingController controller) {
  return Container(
    decoration: const BoxDecoration(
      border: Border.symmetric(horizontal: BorderSide(width: 0.2)),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: controller,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          border: InputBorder.none,
          prefixIcon: SizedBox(
              width: 90,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Text(text,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              )),
          hintText: text,
        ),
      ),
    ),
  );
}
