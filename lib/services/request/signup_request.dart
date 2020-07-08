import 'dart:async';
import 'package:login/models/user.dart';
import 'package:login/data/CtrQuery/signup_ctr.dart';

class SignupRequest {
  SignupCtr con = new SignupCtr();

 Future<User> getSignup(String username, String nombre, String apellido, String correo, String password) {
    var result = con.getSignup(username,nombre,apellido,correo,password);
    return result;
  }
}