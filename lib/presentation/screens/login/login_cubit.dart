
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_gallery/core/end_point/end_point.dart';
import 'package:my_gallery/data/models/login_model.dart';
import 'package:my_gallery/data/remote/dio/dio_helper.dart';
import 'package:my_gallery/presentation/screens/login/login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(InitialState());

  static LoginCubit get(context) => BlocProvider.of(context);



  LoginModel ?loginModel;

  void login({required String email,
    required String password}) {
    emit(LoginLoadingState());

    DioHelper.postData(
        url: LOGINENDPOINT,
        data: {
          'email':email,
          'password':password
        }
    ).then((value) {
      print('//////////////////////////');
      loginModel=LoginModel.fromJson(value.data);
      print(value.data);
      emit(LoginSuccessState(loginModel: loginModel));
    })
        .catchError((error){
      print("Error in SignIn is: ${error.toString()}");
      emit(LoginErrorState());
    });
  }
}
