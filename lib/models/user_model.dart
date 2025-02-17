import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {
  FirebaseAuth _auth = FirebaseAuth.instance;
  String authError = '';
  String errorMessageSignIn = '';
  String errorMessageRecovery = '';
  GoogleSignIn googleSignIn = GoogleSignIn();

  FirebaseUser firebaseUser;
  Map<String, dynamic> userData = Map();
  String googleName = '';
  String googleEmail = '';
  String googlePhoto = '';

  bool isLoading = false;

  static UserModel of(BuildContext context) =>
      ScopedModel.of<UserModel>(context);

  void signUp(
      {@required Map<String, dynamic> userData,
      @required String password,
      @required VoidCallback onSuccess,
      @required Function(String) onFail(String errorMessage)}) {
    isLoading = true;
    notifyListeners();
    _auth
        .createUserWithEmailAndPassword(
      email: userData['email'],
      password: password,
    )
        .then((user) async {
      firebaseUser = user.user;

      await _saveUserData(userData);

      onSuccess();
      isLoading = false;
      print(userData);
      notifyListeners();
    }).catchError((e) {
      switch (e.code) {
        case 'ERROR_INVALID_EMAIL':
          authError = 'O E-mail é inválido!';
          break;
        case 'ERROR_USER_NOT_FOUND':
          authError = 'Usuário não foi encontrado!';
          break;
        case 'ERROR_EMAIL_ALREADY_IN_USE':
          authError = 'O E-mail já está sendo usado!';
          break;
        case 'ERROR_WRONG_PASSWORD':
          authError = 'Senha incorreta!';
          break;
        default:
          authError = 'Error not yet handled! ${e.code}';
          break;
      }
      onFail(authError);
      isLoading = false;
      notifyListeners();
    });
  }

  Future<void> signIn(
      {@required String email,
      @required String password,
      @required VoidCallback onSuccess,
      @required Function(String) onFail(String errorMessage)}) async {
    isLoading = true;

    notifyListeners();
    _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((user) async {
      firebaseUser = user.user;

      await _loadCurrentUser();

      onSuccess();
      isLoading = false;

      notifyListeners();
    }).catchError((e) {
      switch (e.code) {
        case 'ERROR_INVALID_EMAIL':
          errorMessageSignIn = 'E-mail inválido.';
          break;
        case 'ERROR_USER_NOT_FOUND':
          errorMessageSignIn =
              'O usuário não foi encontrado no nosso banco de dados.'
              ' Ele pode ter sido removido.';
          break;
        case 'ERROR_WRONG_PASSWORD':
          errorMessageSignIn = 'A senha está errada.';
          break;
        case 'ERROR_TOO_MANY_REQUESTS':
          errorMessageSignIn = 'Houveram muitas requisições de login. Por'
              ' motivos de segurança, bloqueamos o acesso temporariamente. '
              'Tente novamente mais tarde.';
      }
      onFail(errorMessageSignIn);
      isLoading = false;
      notifyListeners();
    });
  }

  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
    _loadCurrentUser();
  }

  bool isLoggedIn() {
    return firebaseUser != null || googleSignIn.currentUser != null;
  }

  void sendPasswordRecovery(String email, VoidCallback onSuccess,
      Function(String) onError(String errorMessage)) {
    _auth.sendPasswordResetEmail(email: email).then((_) {
      onSuccess();
    }).catchError((e) {
      switch (e.code) {
        case 'ERROR_USER_NOT_FOUND':
          errorMessageRecovery =
              'O usuário não foi encontrado no nosso banco de dados!';
      }
      onError(errorMessageRecovery);
    });
  }

  Future<Null> _saveUserData(Map<String, dynamic> userData) async {
    this.userData = userData;
    await Firestore.instance
        .collection('users')
        .document(firebaseUser.uid)
        .setData(userData);
  }

  void signOut() async {
    await _auth.signOut();
    await googleSignIn.signOut();
    googleName = '';
    googlePhoto = '';
    userData = Map();
    firebaseUser = null;
    notifyListeners();
  }

  Future<Null> _loadCurrentUser() async {
    if (firebaseUser == null) {
      firebaseUser = await _auth.currentUser();
    }
    if (firebaseUser != null) {
      if (userData['name'] == null) {
        DocumentSnapshot docUser = await Firestore.instance
            .collection('users')
            .document(firebaseUser.uid)
            .get();
        userData = docUser.data;
      }
    }
    notifyListeners();
  }

  Future<FirebaseUser> googleLogin() async {
    if (firebaseUser != null) return firebaseUser;
    try {
      final GoogleSignInAccount googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      googleName = googleSignInAccount.displayName;
      googleEmail = googleSignInAccount.email;
      googlePhoto = googleSignInAccount.photoUrl;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      final AuthResult result =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final FirebaseUser firebaseUser = result.user;
      return firebaseUser;
    } catch (error) {
      return null;
    }
  }

  bool isGoogleSignIn() {
    return googleSignIn.currentUser != null;
  }
}
