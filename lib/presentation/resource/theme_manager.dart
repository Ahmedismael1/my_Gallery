
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_gallery/presentation/resource/font_manager.dart';
import 'package:my_gallery/presentation/resource/styles_manager.dart';
import 'package:my_gallery/presentation/resource/values_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(



    buttonTheme: ButtonThemeData(
        shape: StadiumBorder(),
        disabledColor: Colors.grey,
        buttonColor: Colors.blueAccent,
       ),

    textButtonTheme: TextButtonThemeData(
        style: ElevatedButton.styleFrom(
      textStyle: getRegularStyle(
          color: Colors.blue, fontSize: 17),
    )),

    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            textStyle: getBoldStyle(
                color: Colors.white, fontSize: FontSize.s20),
            primary:Colors.blue,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.s12)))),

    textTheme: TextTheme(
        displayLarge:
            getSemiBoldStyle(color: Colors.grey, fontSize: FontSize.s16),
        headlineLarge:
            getSemiBoldStyle(color: Colors.grey, fontSize: FontSize.s16),
        headlineMedium:
            getRegularStyle(color: Colors.grey, fontSize: FontSize.s14),
        titleMedium: getMediumStyle(
            color: Colors.blue, fontSize: FontSize.s16),
        bodyLarge: getRegularStyle(color: Colors.grey),
        bodySmall: getRegularStyle(color: Colors.grey)),

    //input decoration theme (text form field)
    inputDecorationTheme: InputDecorationTheme(
        // content padding
        contentPadding: const EdgeInsets.all(AppPadding.p8),
        // hint style
        hintStyle:
            getMediumStyle(color: Colors.grey, fontSize: FontSize.s16),
        labelStyle:
            getMediumStyle(color: Colors.grey, fontSize: FontSize.s14),
        errorStyle: getRegularStyle(color: Colors.red),
        suffixIconColor: Colors.grey,


        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
              color: Colors.white, width: AppSize.s1_5),
        ),

        // focused border style
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
              color: Colors.blue, width: AppSize.s1_5),
        ),

        // error border style
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.red, width: AppSize.s1_5),
            borderRadius: BorderRadius.circular(20)),
        // focused border style
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.grey, width: AppSize.s1_5),
          borderRadius: BorderRadius.circular(20),
        )
        // enabled border style
      ),
  );
}
