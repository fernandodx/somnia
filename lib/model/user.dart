import 'package:flutter/cupertino.dart';
import 'dart:convert' as convert;

class User {

  String email;
  String senha;

  User();

  User.fromMap(Map<String, dynamic> map) {
    email = map["email"];
    senha = map["senha"];
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['email'] = this.email;
    map['senha'] = this.senha;
    return map;
  }

  String toJson() {
    return convert.json.encode(toMap());
  }

}