
import 'package:my_gallery/data/models/login_model.dart';

abstract class LoginStates{}
class InitialState extends LoginStates{}

class LoginSuccessState extends LoginStates{
  LoginModel? loginModel;
LoginSuccessState({this.loginModel});
}
class LoginLoadingState extends LoginStates{}
class LoginErrorState extends LoginStates{}
