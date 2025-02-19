import 'package:flutter/material.dart';
import 'package:online_exam_app/core/theme/colors_manager.dart';
import 'package:online_exam_app/core/utils/text_style_manger.dart';

class MyThemeData {
  static ThemeData LightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      primaryColor: AppColors.blue_base,
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(
          fontSize: 34,
          color: Colors.grey[700],
        ),
        hintStyle: TextStyle(
          fontSize: 16,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        floatingLabelStyle: TextStyle(
          backgroundColor: Colors.transparent,
          fontSize: 20,
        ),
        fillColor: Colors.white,
        filled: true,
      ),
      secondaryHeaderColor: AppColors.black_base,
      appBarTheme: AppBarTheme(
          centerTitle: false,
          color: AppColors.white,
          elevation: 0,
          iconTheme: IconThemeData(size: 35, color: Colors.black),
          shadowColor: Colors.transparent,
          titleTextStyle: AppTextStyle.medium20),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: AppColors.blue_base,
        unselectedItemColor: AppColors.black_30,
        backgroundColor: Colors.white,
        selectedIconTheme: IconThemeData(
          color: AppColors.blue_base,
        ),
        unselectedIconTheme: IconThemeData(),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(
          color: AppColors.blue_base,
        ),
        unselectedLabelStyle: TextStyle(
          color: AppColors.black_30,
        ),
        elevation: 0,
      ),
      textTheme: TextTheme(
        bodySmall: TextStyle(
          color: AppColors.black_base,
          fontFamily: "ELMessiri",
          fontSize: 12,
          fontWeight: FontWeight.w300,
        ),
        bodyMedium: TextStyle(
          color: AppColors.black_base,
          fontFamily: "ELMessiri",
          fontSize: 17,
          fontWeight: FontWeight.normal,
        ),
        bodyLarge: TextStyle(
          color: AppColors.black_base,
          fontFamily: "ELMessiri",
          fontSize: 25,
          fontWeight: FontWeight.w700,
        ),
      ));
}
