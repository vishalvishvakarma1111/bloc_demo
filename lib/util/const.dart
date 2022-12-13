import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

extension TextEx on TextStyle {
  TextStyle get bold {
    return const TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle get normal => const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.normal,
      );
}

extension InputDeco on InputDecoration {
  InputDecoration get inputDecoration => InputDecoration(
        hintText: "Enter",
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 15),


        constraints: const BoxConstraints(
          maxHeight: 45,
          minHeight: 45,
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.blue)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.blue)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.blue)),
      );
}
