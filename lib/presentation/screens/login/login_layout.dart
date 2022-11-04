import 'dart:ui';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_gallery/core/constant/variable.dart';
import 'package:my_gallery/core/widget/reusable_button.dart';
import 'package:my_gallery/core/widget/toast.dart';
import 'package:my_gallery/data/local/shared_preference/shared_preferences.dart';
import 'package:my_gallery/presentation/resource/assets_manager.dart';
import 'package:my_gallery/presentation/resource/font_manager.dart';
import 'package:my_gallery/presentation/resource/styles_manager.dart';
import 'package:my_gallery/presentation/resource/values_manager.dart';
import 'package:my_gallery/presentation/screens/home/home_layout.dart';
import 'package:my_gallery/presentation/screens/login/login_cubit.dart';
import 'package:my_gallery/presentation/screens/login/login_states.dart';

class LoginLayout extends StatelessWidget {
  var passwordController = TextEditingController();
  var emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            if (state.loginModel!.user != null) {
              CashHelper.saveData(
                  value: state.loginModel!.token!.toString(),
                  key: 'accessToken')
                  .then((value) {
                accessToken = state.loginModel!.token!;
                customToast(
                    title: 'You are login successfully',
                    color: Colors.green);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeLayout()));
              });
            } else if (state.loginModel!.token == null) {
              customToast(
                  title: 'Check Email or Password',
                  color: Colors.red);
            }
          } else if (state is LoginErrorState) {
            customToast(
                title: 'Some Thing goes wrong', color: Colors.red);
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              body: Container(
                decoration: const BoxDecoration(
                    color: Colors.red,
                    image: DecorationImage(
                        image: AssetImage(ImageAssets.loginBackground),
                        fit: BoxFit.cover)),
                child: Align(
                    alignment: AlignmentDirectional.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: AppSize.s150),
                      child: BlurGlassBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.width * 0.9,
                          child:Center(
                            child: Padding(
                              padding: const EdgeInsets.all(AppPadding.p20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'LOG IN',
                                    style: getBoldStyle(
                                        color: Colors.black.withOpacity(0.8), fontSize: FontSize.s35),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white, borderRadius: BorderRadius.circular(20)),
                                    child: TextFormField(
                                      controller: emailController,
                                        decoration: const InputDecoration(
                                          hintText: 'User Name',
                                        )),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white, borderRadius: BorderRadius.circular(20)),
                                    child: TextFormField(
                                      controller: passwordController,
                                      decoration: const InputDecoration(
                                        hintText: 'Password',
                                      ),
                                    ),
                                  ),

                                  ConditionalBuilder(
                                      condition: state is! LoginLoadingState,
                                      builder: (context) => reusableButton(
                                        text: 'Login',
                                        onPressed: () {
                                          LoginCubit.get(context).login(
                                              email: emailController.text,
                                              password:
                                              passwordController.text);
                                        },
                                        context: context,
                                      ),
                                      fallback: (context) => const Center(
                                        child: CircularProgressIndicator(),
                                      )),

                                ],
                              ),
                            ),
                          )),
                    )),
              ),
            ),
          );
        },
      ),
    );
  }
}

class BlurGlassBox extends StatelessWidget {
  const BlurGlassBox(
      {Key? key,
      required this.width,
      required this.height,
      required this.child})
      : super(key: key);
  final double width, height;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Container(
        width: width,
        height: height,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.25), blurRadius: 30)
                  ],
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withOpacity(0.6),
                        Colors.white.withOpacity(0.4)
                      ],
                      stops: const [
                        0.0,
                        0.1
                      ])),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
              child: SizedBox(
                width: width,
                height: height,
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
