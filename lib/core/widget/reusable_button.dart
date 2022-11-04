import 'package:flutter/material.dart';
import 'package:my_gallery/presentation/resource/values_manager.dart';

Widget reusableButton({context, required String text, required Function() onPressed,})=> SizedBox(
  width: MediaQuery.of(context).size.width ,
  height: AppSize.s45,
  child: ElevatedButton(
      onPressed: onPressed,
      child:  Text(text)),
);