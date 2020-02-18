import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:somnia/model/response_api.dart';
import 'package:somnia/resources/strings.dart';

String fireBaseUserUid;

class FirebaseService {

  final _googleSign = GoogleSignIn();
  final _auth = FirebaseAuth.instance;

  Future<ResponseApi> loginWithEmailAndPassword(BuildContext context, String email, String password) async {

    try{

      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      final FirebaseUser user = await result.user;
      print("Login realizado com sucesso!!!");
      print("Nome: ${user.displayName}");
      print("E-mail: ${user.email}");
      print("Foto: ${user.photoUrl}");
//      saveUser(context, user);

      return ResponseApi<FirebaseUser>.ok(result: user);

    }catch(error){

      String msg = "Não foi possível autenticar o seu usuário.";

      if(error is PlatformException){
        PlatformException exception = error as PlatformException;

        switch (exception.code) {
          case 'ERROR_INVALID_EMAIL':
            msg = Strings.msgErroEmailInvalid;
            break;
          case 'ERROR_USER_NOT_FOUND':
            msg = Strings.msgErroUserNotFound;
            break;
          case 'ERROR_WRONG_PASSWORD':
            msg = Strings.msgErroPasswordWrong;
            break;
          default:
            break;
        }
        print("Login with Google COD: ${exception.code} MSG: ${exception.message}");
      }else{
        print("Login with Google error: $error");
      }
      return ResponseApi<FirebaseUser>.error(msg: msg);
    }
  }

  Future<ResponseApi> updateUser(BuildContext context, {name, urlPhoto}) async {

    try{

      final updateUser = UserUpdateInfo();
      if(urlPhoto != null){
        updateUser.photoUrl = urlPhoto;
      }
      updateUser.displayName = name ?? "";

      var user = await FirebaseAuth.instance.currentUser();
      user.updateProfile(updateUser);
//      saveUser(context, user);

      return ResponseApi<FirebaseUser>.ok(result: user);

    }catch(error){
      print("Erro ao criar o usuário: ${error}");
      return ResponseApi<FirebaseUser>.error(msg: error.toString());
    }

  }


  Future<ResponseApi> createUserWithEmailAndPassword(BuildContext context, String email, String password, {String name, String urlPhoto}) async {

    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      final FirebaseUser user = await result.user;

//      saveUser(context, user);

      if(name != null || urlPhoto != null){
        final updateUser = UserUpdateInfo();
        updateUser.photoUrl = urlPhoto ?? "https://image.flaticon.com/icons/svg/147/147144.svg";
        updateUser.displayName = name ?? "";
        user.updateProfile(updateUser);
      }

      return ResponseApi<FirebaseUser>.ok(result: user);

    }catch(error){
      if(error is PlatformException) {
        print("Erro ao criar o usuário: cod - ${error.code} mensagem - ${error.message}");
        return ResponseApi<FirebaseUser>.error(msg: error.toString());
      }
      print("Erro ao criar o usuário: ${error}");
      return ResponseApi<FirebaseUser>.error(msg: error.toString());
    }
  }

  Future<ResponseApi> loginWithGoogle(BuildContext context) async {

    try{

      final GoogleSignInAccount account = await _googleSign.signIn();
      final GoogleSignInAuthentication authentication = await account.authentication;

      print("Google User: ${account.email}");

      final AuthCredential credential = GoogleAuthProvider.getCredential(
          idToken: authentication.idToken,
          accessToken: authentication.accessToken);

      AuthResult result = await _auth.signInWithCredential(credential);
      final FirebaseUser user = await result.user;
//      saveUser(context, user);
      print("Login realizado com sucesso!!!");
      print("Nome: ${user.displayName}");
      print("E-mail: ${user.email}");
      print("Foto: ${user.photoUrl}");

      return ResponseApi<FirebaseUser>.ok(result: user);

    }catch(error){
      print("Login with Google error: $error");
      return ResponseApi.error(msg: error.toString());
    }

  }

//  void saveUser(BuildContext context, FirebaseUser user){
//    if(user != null){
//      fireBaseUserUid = user.uid;
//      DocumentReference refUsers = Firestore.instance.collection("users").document(fireBaseUserUid);
//      refUsers.setData({"name" : user.displayName, "e-mail" : user.email });
//      MainEventBus().get(context).updateUser(user);
//    }
//  }

  logout() {
    _auth.signOut();
    _googleSign.signOut();
  }




}