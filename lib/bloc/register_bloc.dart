import 'package:flutter/cupertino.dart';
import 'package:somnia/model/user.dart';

class RegisterBloc {

  final formKey = GlobalKey<FormState>();
  final user = User();
  final validedPasswordController = TextEditingController();


  resgisterUser() {

    if(formKey.currentState.validate()){
       formKey.currentState.save();




    }


  }



}