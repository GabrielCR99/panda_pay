import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pandapay/models/user_model.dart';
import 'package:pandapay/screens/home_screen.dart';
import 'package:pandapay/screens/password_recovery_screen.dart';
import 'package:pandapay/screens/signup/sign_up_screen.dart';
import 'package:pandapay/widgets/input_field.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  FirebaseUser _currentUser;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  static final Pattern pattern =
      r"^(([^<>()[\]\\.,;:\s@\']+(\.[^<>()[\]\\.,;:\s@\']+)*)|(\'.+\'))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          if (model.isLoading)
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.blue),
              ),
            );
          else
            return Form(
              key: _formKey,
              child: Stack(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(16.0),
                    color: Colors.white,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Image.asset(
                            'images/PandaPay_Horizontal_SemSlogan_Black.png',
                            height: 50,
                          ),
                          const SizedBox(height: 36.0),
                          InputField(
                            textCapitalization: TextCapitalization.none,
                            keyboardType: TextInputType.emailAddress,
                            isObscure: false,
                            controller: _emailController,
                            suffixIcon: Icon(Icons.email),
                            labelText: 'Login',
                            hint: 'E-mail ou CPF/CNPJ',
                            validateText: (email) {
                              if (email.isEmpty ||
                                  !email.contains(RegExp(pattern)))
                                return 'E-mail inválido!';
                              return null;
                            },
                          ),
                          const SizedBox(height: 16.0),
                          InputField(
                            textCapitalization: TextCapitalization.none,
                            suffixIcon: Icon(Icons.lock),
                            isObscure: true,
                            controller: _passwordController,
                            labelText: 'Senha',
                            hint: 'Senha cadastrada',
                            validateText: (password) {
                              if (password.isEmpty) return 'Senha inválida!';
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 20.0, bottom: 10.0),
                            child: Container(
                              child: SizedBox(
                                width: 220.0,
                                child: RaisedButton(
                                  color: Colors.blueGrey,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState.validate())
                                      model.signIn(
                                          email: _emailController.text,
                                          password: _passwordController.text,
                                          onSuccess: _onSuccess,
                                          onFail: (errorMessage) {
                                            _onFail(errorMessage);
                                            return null;
                                          });
                                  },
                                  child: const Text(
                                    'Entrar',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => PasswordRecovery()));
                            },
                            child: const Text(
                              'Esqueceu sua senha do PandaPay?',
                              style: TextStyle(fontWeight: FontWeight.w600),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            height: 50.0,
                          ),
                          const Text(
                            'Acessar com:',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          SignInButton(
                            Buttons.Google,
                            text: 'Google',
                            onPressed: () async {
                              model.signOut();
//                              FirebaseUser user = await getUser();
//                              if (user == null)
                              _scaffoldKey.currentState.showSnackBar(
                                SnackBar(
                                  content: Text('text'),
                                ),
                              );
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()),
                              );
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          SignInButton(
                            Buttons.Facebook,
                            text: 'Facebook',
                            onPressed: () {},
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          const SizedBox(height: 60.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: const Text(
                                  'Não tem uma conta no PandaPay? ',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SignUpScreen()));
                                  },
                                  child: const Text(
                                    'Cadastre-se!',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.blue,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.onAuthStateChanged.listen((user) {
      _currentUser = user;
    });
  }

  Future<FirebaseUser> getUser() async {
    if (_currentUser != null) return _currentUser;
    try {
      final GoogleSignInAccount googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
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

  void _onSuccess() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
  }

  void _onFail(String errorMessage) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(
          'Falha ao entrar! $errorMessage',
        ),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 3),
      ),
    );
  }
}
