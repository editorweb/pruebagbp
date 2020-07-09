import 'package:flutter/material.dart';
import 'package:login/models/user.dart';
import 'package:login/screen/home_page.dart';
import 'package:login/services/response/signup_response.dart';
import 'package:login/data/database_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => new _SignupPageState();
}

enum SignupStatus { notSignUp, signUp }

class _SignupPageState extends State<SignupPage> implements SignupCallBack {
  SignupStatus _signupStatus = SignupStatus.notSignUp;
  BuildContext _ctx;
  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  
  String _username, _password,  _nombre, _apellido, _correo;

  SignupResponse _response;

  _SignupPageState() {
    _response = new SignupResponse(this);
  }

  void _submit() {
    final form = formKey.currentState;

    if (form.validate()) {
      setState(() {
        _isLoading = true;
        form.save();
       var user = new User(_username, _nombre, _apellido, _correo, _password);
        var db = new DatabaseHelper();
        db.saveUser(user);
        _isLoading = false;
        Navigator.of(context).pushNamed("/login");

      });
    }
  }
  

  void _showSnackBar(String text) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(text),
    ));
  }

  var value;
 getPref() async {
   SharedPreferences preferences = await SharedPreferences.getInstance();
   setState(() {
     value = preferences.getInt("value");

     _signupStatus = value == 1 ? SignupStatus.signUp : SignupStatus.notSignUp;
   });
 }

   signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", null);
      preferences.commit();
      _signupStatus = SignupStatus.notSignUp;
    });
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
      switch (_signupStatus) {
        case SignupStatus.notSignUp:
          _ctx = context;
          var signupBtn = new RaisedButton(
            onPressed: _submit,
            child: new Text("Registrar"),
            color: Colors.green,
          );
          var signupForm = new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Form(
                key: formKey,
                child: new Column(
                  children: <Widget>[
                    new Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: new TextFormField(
                        validator: (value) {
                        if (value.isEmpty) {
                         return 'Por favor ingrese su usuario';
                       }
                          return null;
                        },
                        onSaved: (val) => _username = val,
                        decoration: new InputDecoration(labelText: "Username"),
                      ),
                    ), new Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: new TextFormField(
                        validator: (value) {
                        if (value.isEmpty) {
                         return 'Por favor ingrese su nombre';
                       }
                          return null;
                        },
                        onSaved: (val) => _nombre = val,
                        decoration: new InputDecoration(labelText: "Nombre"),
                      ),
                    ),
                     new Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: new TextFormField(
                        validator: (value) {
                        if (value.isEmpty) {
                         return 'Por favor ingrese su apellido';
                       }
                          return null;
                        },
                        onSaved: (val) => _apellido = val,
                        decoration: new InputDecoration(labelText: "Apellido"),
                      ),
                    ),
                     new Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: new TextFormField(
                        validator: (value) {
                        if (value.isEmpty) {
                         return 'Por favor ingrese su correo';
                       }
                          return null;
                        },
                        onSaved: (val) => _correo = val,
                        decoration: new InputDecoration(labelText: "Correo"),
                      ),
                    ),
                    new Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: new TextFormField(
                        validator: (value) {
                        if (value.isEmpty) {
                         return 'Por favor ingrese su contraseña';
                       }
                          return null;
                        },
                        onSaved: (val) => _password = val,
                        decoration: new InputDecoration(labelText: "Contraseña"),
                      ),
                    )
                  ],
                ),
              ),
              signupBtn
            ],
          );

           return new Scaffold(
            appBar: new AppBar(
              title: new Text("Signup Page"),
            ),
            key: scaffoldKey,
            body: new Container(
              child: new Center(
                child: signupForm,
              ),
            ),
          );
          break;
        case SignupStatus.signUp:
          return HomeScreen(signOut);
          break;
    }
  }

  savePref(int value,String user, String pass) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", value);
      preferences.setString("user", user);
      preferences.setString("pass", pass);
      preferences.commit();
    });
  }

  @override
  void onSignupError(String error) {
    _showSnackBar(error);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void onSignupSuccess(User user) async {    

    if(user != null){
      savePref(1,user.username, user.password);
      _signupStatus = SignupStatus.signUp;
    }else{
      _showSnackBar("error en el registro");
      setState(() {
        _isLoading = false;
      });
    }
    
  }
}