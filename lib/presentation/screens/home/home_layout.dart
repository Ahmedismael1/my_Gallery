import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_gallery/data/local/shared_preference/shared_preferences.dart';
import 'package:my_gallery/logic/app_cubit.dart';
import 'package:my_gallery/logic/app_states.dart';
import 'package:my_gallery/presentation/resource/assets_manager.dart';
import 'package:my_gallery/presentation/resource/font_manager.dart';
import 'package:my_gallery/presentation/resource/styles_manager.dart';
import 'package:my_gallery/presentation/resource/values_manager.dart';
import 'package:my_gallery/presentation/screens/home/home_widget.dart';
import 'package:my_gallery/presentation/screens/login/login_layout.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
            listener: (context, state) {
              if(state is UploadGalleryImageSuccessState){
                AppCubit.get(context). getImages();

              }
            },
            builder: (context, state) {
              return SafeArea(
                  child: Scaffold(
                      body: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(ImageAssets.homeBackground),
                        fit: BoxFit.cover)),
                child: Padding(
                  padding: const EdgeInsets.all(AppPadding.p8),
                  child: ListView(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Welcome,\n Mina',
                            style: getBoldStyle(
                                color: Colors.black, fontSize: FontSize.s35),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: NetworkImage(
                                        'https://pps.whatsapp.net/v/t61.24694-24/294932579_736941360877280_6673647483651150354_n.jpg?ccb=11-4&oh=01_AdTiAuQHveFQ2h3Z13EUc4rR54IlU9CwRRPkTjdMNI303A&oe=6371A63F'),
                                    fit: BoxFit.fill),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: AppSize.s40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ////logout////
                          logoutUploadButton(
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SvgPicture.asset(
                                        ImageAssets.logout,
                                      ),
                                      Text(
                                        'Logout',
                                        style: getBoldStyle(
                                            color: Colors.black,
                                            fontSize: FontSize.s16),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              onTap: () {
                                CashHelper.removeData(key: 'accessToken')
                                    .then((value) {
                                  if (value) {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LoginLayout()),
                                        (route) => false);
                                  }
                                });
                              }),
                          ////upload photo////
                          logoutUploadButton(
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SvgPicture.asset(
                                        ImageAssets.upload,
                                      ),
                                      Text(
                                        'Upload',
                                        style: getBoldStyle(
                                            color: Colors.black,
                                            fontSize: FontSize.s16),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              onTap: () {
                              AppCubit.get(context).getPostImage();
                              }),
                        ],
                      ),
                      (AppCubit.get(context).getImagesModel != null)
                          ? Container(
                              child: GridView.count(
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                crossAxisCount: 3,
                                mainAxisSpacing: 1.0,
                                crossAxisSpacing: 1.0,
                                childAspectRatio: 1 / 1.5,
                                children: List.generate(
                                  AppCubit.get(context)
                                      .getImagesModel!
                                      .data!
                                      .images!
                                      .length,
                                  (index) => buildMyImage(
                                      index: index, context: context),
                                ),
                              ),
                            )
                          : Center(
                              child: CircularProgressIndicator(),
                            ),
                    ],
                  ),
                ),
              )));
            });
  }

  Widget buildMyImage({index, context}) => Padding(
        padding: const EdgeInsets.all(AppPadding.p20),
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      '${AppCubit.get(context).getImagesModel!.data!.images![index]}'),
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(15)),
        ),
      );
}

// class RPSCustomPainter extends CustomPainter{
//
//   @override
//   void paint(Canvas canvas, Size size) {
//
//
//
//     Paint paint0 = Paint()
//       ..color = const Color(0xffDDCDFF)
//       ..style = PaintingStyle.fill
//
//       ..strokeWidth = 1.0;
//
//
//     Path path0 = Path();
//     canvas.drawShadow(path0, Colors.grey, 10, false);
//     path0.moveTo(size.width,0);
//     path0.quadraticBezierTo(size.width*0.4373594,0,size.width*0.2498125,0);
//     path0.quadraticBezierTo(size.width*0.4609250,size.height*0.0670400,size.width*0.4534375,size.height*0.3590000);
//     path0.quadraticBezierTo(size.width*0.4421125,size.height*0.6097600,size.width*0.5625000,size.height*0.7000000);
//     path0.cubicTo(size.width*0.6223500,size.height*0.7419800,size.width*0.7016875,size.height*0.7467800,size.width*0.7485625,size.height*0.7405000);
//     path0.cubicTo(size.width*0.8933125,size.height*0.7201400,size.width*0.9372625,size.height*0.8174800,size.width*0.9518250,size.height*0.8394600);
//     path0.cubicTo(size.width*0.9828375,size.height*0.8935200,size.width*1.0039625,size.height*0.9705600,size.width,size.height);
//     path0.quadraticBezierTo(size.width*1.0003875,size.height*0.9766800,size.width,0);
//     path0.close();
//
//     canvas.drawPath(path0, paint0);
//
//
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
//
// }
