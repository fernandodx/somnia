import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:somnia/api/firebase_service.dart';
import 'package:somnia/bloc/base_bloc.dart';
import 'package:somnia/model/response_api.dart';
import 'package:somnia/model/user.dart';
import 'package:somnia/widget/alert_bottom_sheet.dart';

class LoginBloc extends BaseBloc {
  final formKey = GlobalKey<FormState>();

  User user = User();

  Future<FirebaseUser> login(BuildContext context) async {

    if (!formKey.currentState.validate()) {
      print("Erro na validação");
      return null;
    }

    showLoading();

    print("USER : ${user.email} SENHA: ${user.password}");

    formKey.currentState.save();

    ResponseApi responseApi = await FirebaseService()
        .loginWithEmailAndPassword(context, user.email, user.password);

    hideLoading();

    if (responseApi.ok) {
      FirebaseUser user = responseApi.result;
      print("LOGIN REALIZADO: ${user.email} Foto: ${user.photoUrl}");
      return user;
    } else {
      alertBottomSheet(
        context,
        msg: responseApi.msg,
        title: "Erro na Autenticação",
        tipoAlert: TipoAlert.ERROR
      );
      return null;
    }
  }
}
