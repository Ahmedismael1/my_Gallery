import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_gallery/core/bloc_observer/bloc_observer.dart';
import 'package:my_gallery/core/constant/variable.dart';
import 'package:my_gallery/data/local/shared_preference/shared_preferences.dart';
import 'package:my_gallery/data/remote/dio/dio_helper.dart';
import 'package:my_gallery/logic/app_cubit.dart';
import 'package:my_gallery/presentation/resource/theme_manager.dart';
import 'package:my_gallery/presentation/screens/home/home_layout.dart';
import 'package:my_gallery/presentation/screens/login/login_layout.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();
  await CashHelper.init();
  Widget widget;
  accessToken = CashHelper.getData(key: 'accessToken');
  print(accessToken);
  if (accessToken != null) {
    widget = const HomeLayout();
  } else {
    widget = LoginLayout();
  }
  BlocOverrides.runZoned(
    () {
      runApp(MyApp(
        startWidget: widget,
      ));
    },
    blocObserver: SimpleBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.startWidget}) : super(key: key);
  final Widget startWidget;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..getImages(),
      child: ResponsiveSizer(builder: (context, orientation, screenType) {
        return MaterialApp(
          title: 'My Gallary',
          theme: getApplicationTheme(),
          home: startWidget,
        );
      }),
    );
  }
}
