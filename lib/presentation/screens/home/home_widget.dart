import 'package:flutter/material.dart';
import 'package:my_gallery/presentation/resource/font_manager.dart';
import 'package:my_gallery/presentation/resource/styles_manager.dart';
import 'package:my_gallery/presentation/resource/values_manager.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Widget logoutUploadButton({required Widget child,required Function() onTap})=> InkWell(
  onTap: onTap,
  child: child,
);

Widget uploadButtons({
  context,
  required String image,
  required String type,
  required Function() onTap
})=> Padding(
  padding: const EdgeInsets.all(
      AppPadding.p20),
  child: InkWell(
    onTap: onTap,
    child: Container(
      width: MediaQuery.of(
          context)
          .size
          .width *
          0.5,
      height: 6.h,
      decoration: BoxDecoration(
          color:
          Colors.white,
          borderRadius:
          BorderRadius
              .circular(
              10)),
      child: Row(
        mainAxisAlignment:
        MainAxisAlignment
            .spaceEvenly,
        children: [
          Image(
            image:
             AssetImage(image,
            ),
            width: 6.h,
            height: 6.h,
          ),
          Text(
            type,
            style: getBoldStyle(
                color: Colors
                    .black,
                fontSize:
                FontSize
                    .s22),
          )
        ],
      ),
    ),
  ),
);