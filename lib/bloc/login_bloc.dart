import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:somnia/api/firebase_service.dart';
import 'package:somnia/model/response_api.dart';
import 'package:somnia/model/user.dart';
import 'package:somnia/widget/alert_bottom_sheet.dart';

class LoginBloc {

  final formKey = GlobalKey<FormState>();

  User user = User();



  onClickEntrar(BuildContext context) async {

//    if(!formKey.currentState.validate()){
//      print("Erro na validação");
//      return;
//    }
//
//    print("USER : ${user.email} SENHA: ${user.senha}");
//
//    formKey.currentState.save();
//
//    ResponseApi responseApi = await FirebaseService().loginWithEmailAndPassword(context, user.email, user.senha);
//
//    if(responseApi.ok){
//      FirebaseUser user = responseApi.result;
//      print("LOGIN REALIZADO: ${user.email} Foto: ${user.photoUrl}");
//    }else{
//      alertBottomSheet(context, msg: responseApi.msg);
      alertBottomSheet(context, msg: "Erro na autenticação");
//    }

  }

  String validatorEmail(String value) {
    if (value.isEmpty) {
      return "E-mail é obrigatório";
    }
    return null;
  }

  String validatorPassword(String value) {
    if (value.isEmpty) {
      return "Senha é obrigatório";
    }
    if (value.length < 4) {
      return "Sua senha tem que ter no minímo 8 dígitos";
    }
    return null;
  }


}