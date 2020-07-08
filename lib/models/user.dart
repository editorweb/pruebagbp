class User {
  int _id;
  String _username;
  String _nombre;
  String _apellido;
  String _correo;
  String _password;

  User(this._username, this._nombre,this._apellido,this._correo, this._password);

  User.fromMap(dynamic obj) {
    this._username = obj['username'];
    this._nombre = obj['nobre'];
    this._apellido = obj['apellido'];
    this._correo = obj['correo'];
    this._password = obj['password'];
  }

  String get username => _username;
  String get nombre => _nombre;
  String get apellido => _apellido;
  String get correo => _correo;
  String get password => _password;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["username"] = _username;
    map["nombre"] = _nombre;
    map["apellido"] = _apellido;
    map["correo"] = _correo;
    map["password"] = _password;
    return map;
  }
}