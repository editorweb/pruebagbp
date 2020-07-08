import 'package:login/models/user.dart';
import 'dart:async';
import 'package:login/data/database_helper.dart';

class SignupCtr {
DatabaseHelper con = new DatabaseHelper();

//insertion
  Future<int> saveUser(User user) async {
    var dbClient = await con.db;
    int res = await dbClient.insert("User", user.toMap());
    return res;
  }

  //deletion
  Future<int> deleteUser(User user) async {
    var dbClient = await con.db;
    int res = await dbClient.delete("User");
    return res;
  }

  Future<User> getSignup(String username, String nombre, String apellido, String correo, String password) async {
    var dbClient = await con.db;
    var res = await dbClient.rawQuery("INSERT INTO user (username, nombre, apellido, correo, password) values ($username,$nombre,$apellido,$correo,$password)");
    
    if (res.length > 0) {
      return new User.fromMap(res.first);
    }

    return null;
  }

  Future<List<User>> getAllUser() async {
    var dbClient = await con.db;
    var res = await dbClient.query("user");
    
    List<User> list =
        res.isNotEmpty ? res.map((c) => User.fromMap(c)).toList() : null;

    return list;
  }
}