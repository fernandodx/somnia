import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:somnia/bloc/login_bloc.dart';
import 'package:somnia/resources/app_colors.dart';
import 'package:somnia/utils/text_util.dart';
import 'package:somnia/widget/app_button_default.dart';
import 'package:somnia/widget/app_text_default.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final _bloc = LoginBloc();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _bloc.formKey,
        child: Stack(
          children: <Widget>[
            Container(
              decoration: AppColors.backgroundBoxDecoration(),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 100,
                  height: 100,
                  child: Image.asset("assets/images/logoSomnia.png"),
                ),
                Container(
                  margin: EdgeInsets.all(16),
                  constraints: BoxConstraints(minWidth: 500.0, minHeight: 300.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0)),
                    elevation: 10.0,
                    child: Container(
                      margin: EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          TextUtil.textTitulo("Login"),
                          SizedBox(height: 16),
                          AppTextDefault(
                            validator: _bloc.validatorEmail,
                            inputType: TextInputType.emailAddress,
                            inputAction: TextInputAction.next,
                            onSaved: (value) => _bloc.user.email = value,
                            name: "E-mail",
                          ),
                          SizedBox(height: 16),
                          AppTextDefault(
                            validator: _bloc.validatorPassword,
                            inputAction: TextInputAction.done,
                            isPassword: true,
                            inputType: TextInputType.text,
                            onSaved: (value) => _bloc.user.senha = value,
                            name: "Senha",
                          ),
                          SizedBox(height: 16),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: AppButtonDefault(
                                  label: "Entrar",
                                  onPressed: () => _bloc.onClickEntrar(context),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          AppButtonDefault(
                              decoration: TextDecoration.underline,
                              label: "Não tenho conta",
                              type: TypeButton.FLAT,
                              onPressed: () => print("")),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  constraints: BoxConstraints(
                                    minWidth: 300,
                                    maxHeight: 2,
                                  ),
                                  color: AppColors.colorPrimary,
                                ),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Text(
                                "OU",
                                style: TextStyle(
                                    color: AppColors.colorPrimary,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                child: Container(
                                  constraints: BoxConstraints(
                                    minWidth: 300,
                                    maxHeight: 2,
                                  ),
                                  color: AppColors.colorPrimary,
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 16),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: GoogleSignInButton(
                                  onPressed: () => print(""),
                                  borderRadius: 8.0,
                                  text: "Login com Google",
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: FacebookSignInButton(
                                  onPressed: () => print(""),
                                  borderRadius: 8.0,
                                  text: "Login com Facebook",
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
