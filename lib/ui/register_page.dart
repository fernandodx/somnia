import 'package:flutter/material.dart';
import 'package:somnia/bloc/register_bloc.dart';
import 'package:somnia/resources/app_colors.dart';
import 'package:somnia/resources/strings.dart';
import 'package:somnia/utils/text_util.dart';
import 'package:somnia/utils/utils.dart';
import 'package:somnia/utils/validator_util.dart';
import 'package:somnia/widget/app_text_default.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _bloc = RegisterBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: Utils.isCenterTitleAppBar(),
        title: TextUtil.textAppbar(Strings.titleRegisterEmail),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.check,
              ),
              onPressed: () => print("save")),
        ],
      ),
      body: Column(
        children: <Widget>[
          headerRegister(),
          Expanded(
            child: Form(
              key: _bloc.formKey,
              child: Container(
                padding: EdgeInsets.all(16),
                color: Colors.white,
                child: ListView(
                  children: <Widget>[
                    AppTextDefault(
                      name: "Nome",
                      inputAction: TextInputAction.next,
                      inputType: TextInputType.text,
                      onSaved: (name) => _bloc.user.name = name,
                      validator: ValidatorUtil.requiredField,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    AppTextDefault(
                      name: "E-mal",
                      inputAction: TextInputAction.next,
                      inputType: TextInputType.emailAddress,
                      onSaved: (email) => _bloc.user.email = email,
                      validator: ValidatorUtil.validatorEmail,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    AppTextDefault(
                      name: "Senha",
                      inputAction: TextInputAction.next,
                      inputType: TextInputType.visiblePassword,
                      isPassword: true,
                      onSaved: (password) => _bloc.user.password = password,
                      validator: (value) =>
                          ValidatorUtil.validatorPasswordWithRepit(
                              value, _bloc.validedPasswordController),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    AppTextDefault(
                      name: "Repita a senha",
                      inputAction: TextInputAction.next,
                      inputType: TextInputType.visiblePassword,
                      isPassword: true,
                      controller: _bloc.validedPasswordController,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Container headerRegister() {
    return Container(
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Container(
            height: 150,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [AppColors.colorPrimary, AppColors.colorPrimaryDark],
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter),
              borderRadius: BorderRadiusDirectional.only(
                  bottomEnd: Radius.elliptical(300, 160),
                  bottomStart: Radius.elliptical(300, 160)),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 60),
                width: 150,
                height: 150,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://cactusthemes.com/blog/wp-content/uploads/2018/01/tt_avatar_small.jpg"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
