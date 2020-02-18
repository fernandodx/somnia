import 'package:flutter/cupertino.dart';
import 'dart:convert' as convert;

class User {

  String email;
  String senha;
  String name;
  String password;
  String urlPicture;

  User();

  User.fromMap(Map<String, dynamic> map) {
    email = map["email"];
    senha = map["senha"];
    name = map["name"];
    password = map["password"];
    urlPicture = map["urlPicture"];
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['email'] = this.email;
    map['senha'] = this.senha;
    map["name"] = this.name;
    map["password"] = this.password;
    map["urlPicture"] = this.urlPicture;
    return map;
  }

  String toJson() {
    return convert.json.encode(toMap());
  }

}