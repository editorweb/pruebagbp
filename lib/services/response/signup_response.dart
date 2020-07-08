import 'package:login/services/request/signup_request.dart';
import 'package:login/models/user.dart';

abstract class SignupCallBack {
  void onSignupSuccess(User user);
  void onSignupError(String error);
}

class SignupResponse {
 SignupCallBack _callBack;
  SignupRequest signupRequest = new SignupRequest();
  SignupResponse(this._callBack);

  doSignup(String username, String nombre, String apellido, String correo, String password) {
    
  } 
}