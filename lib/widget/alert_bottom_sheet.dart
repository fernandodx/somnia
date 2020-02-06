import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:somnia/resources/app_colors.dart';

alertBottomSheet(
  BuildContext context, {
  @required String msg,
  Function onPressOk,
  String title = "Alerta",
}) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 40),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      height: 40,
                      color: AppColors.colorAcent,
                    ),
                    Container(
                      height: 100,
                      color: Colors.white,
                    ),
                    ButtonBarTheme(
                      child: ButtonBar(
                        children: <Widget>[
                          FlatButton(
                            child: Text('OK'),
                            onPressed: () => Navigator.pop(context),
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          FlatButton(
                            child: Text('CANCELAR'),
                            onPressed: () => Navigator.pop(context),
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: 80,
                    height: 80,
                    child: FlareActor(
                      "assets/animations/error.flr",
                      shouldClip: true,
                      animation: "Error",
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      });
}

Container bodyAredondado(BuildContext context) {
  return Container(
    height: 250.0,
    color: Colors.transparent,
    child: Container(
        decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(15.0),
                topRight: const Radius.circular(15.0))),
        child: new Center(
          child: FlatButton(
            child: Text('OK'),
            onPressed: () => Navigator.pop(context),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        )),
  );
}

Container body(BuildContext context) {
  return Container(
    color: Colors.transparent,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 50,
              height: 50,
              color: AppColors.colorPrimaryDark,
              child: FlareActor(
                "assets/animations/error.flr",
                shouldClip: true,
                animation: "Error",
              ),
            ),
            Expanded(
              child: Container(
                height: 50,
                color: AppColors.colorPrimaryDark,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Alerta",
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                ),
              ),
            ),
          ],
        ),
        Container(
          height: 100,
          color: Colors.white,
        ),
        ButtonBarTheme(
          data: ButtonBarThemeData(
            buttonMinWidth: 50,
          ),
          child: ButtonBar(
            buttonPadding: EdgeInsets.all(16),
            children: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () => Navigator.pop(context),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              FlatButton(
                child: Text('CANCELAR'),
                onPressed: () => Navigator.pop(context),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
