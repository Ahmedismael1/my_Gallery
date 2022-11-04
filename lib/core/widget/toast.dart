import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

customToast({
      required String title,
      required Color color
    })
{

  Fluttertoast.showToast(
      msg: title,
      textColor: Colors.white,
      backgroundColor: color,
      gravity: ToastGravity.BOTTOM
  );

}
