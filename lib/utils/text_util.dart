import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:somnia/resources/app_colors.dart';

class TextUtil {
  static Text textAppbar(String value) {
    return Text(
      value,
      style: TextStyle(
        fontSize: 20,
        color: Colors.white,
      ),
    );
  }

  static Text textDefault(String value) {
    return Text(
      value,
      style: TextStyle(
        fontSize: 14,
        color: Colors.blueGrey,
      ),
    );
  }

  static Text textTitulo(String value, {color = AppColors.colorPrimaryDark}) {
    return Text(
      value,
      style: TextStyle(fontSize: 20, color: color, fontWeight: FontWeight.bold),
    );
  }
}
