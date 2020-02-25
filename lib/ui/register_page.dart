import 'package:cloud_firestore/cloud_firestore.dart';
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
  void initState() {
    super.initState();

    try{
      DocumentReference refUsers =
      Firestore.instance.collection("dataHour").document("user1");
      refUsers.setData(
          {"name": "Fernando", "e-mail": "Dias teset"}, merge: true)
          .whenComplete(() {
        print("FIRE STORE FINISH");
      })
          .catchError((error) {
        print("ERRO AO SALVAR O USUARIO : $error");
      });
    }catch(error){
      print("ERRO TRY - $error");
    }

    _bloc.fetch();
  }

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
              onPressed: () => _bloc.resgisterUser(context)),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              headerRegister(),
              Expanded(
                child: Form(
                  key: _bloc.formKey,
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        gradient: AppColors.backgroundPageGradient()),
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
                          name: "Confirme o e-mail",
                          inputAction: TextInputAction.next,
                          inputType: TextInputType.emailAddress,
                          controller: _bloc.validatedEmailController,
                          validator: ValidatorUtil.requiredField,
                          onSaved: (emailConfirmated) =>
                              ValidatorUtil.fieldsEquals(emailConfirmated,
                                  _bloc.validatedEmailController),
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
                          validator: ValidatorUtil.validatorPassword,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          _bloc.loading(),
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
                decoration: BoxDecoration(
                  color: Colors.white, // border color
                  shape: BoxShape.circle,
                ),
                width: 130,
                height: 130,
                child: createStreamBuilderPhotoUser(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  StreamBuilder<Widget> createStreamBuilderPhotoUser() {
    return StreamBuilder<Widget>(
      stream: _bloc.pictureStream,
      builder: (context, snapshot) {

        if (snapshot.hasData) {
          return InkWell(
            child: snapshot.data,
            onTap: () => _bloc.onAddImage(),
          );
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
