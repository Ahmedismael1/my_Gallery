import 'package:flutter/material.dart';

Widget logoutUploadButton({required Widget child,required Function() onTap})=> InkWell(
  onTap: onTap,
  child: child,
);

