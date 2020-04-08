import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
                        crossAxisAlignment: CrossAxisAlignment.stretch,
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
                          Align(
                            alignment: Alignment.bottomRight,
                            heightFactor: 1.5,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => PasswordRecovery()));
                              },
                              child: const Text(
                                'Esqueceu sua senha do PandaPay?',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 20.0, bottom: 10.0),
                            child: Container(
                              height: 50,
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
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40.0,
                          ),
                          const Text(
                            'Acessar com:',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Container(
                            height: 50,
                            child: RaisedButton(
                              color: Color(0xFFFFFFFF),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              onPressed: () async {
                                FirebaseUser user = await model.googleLogin();
                                if (user == null)
                                  _scaffoldKey.currentState.showSnackBar(
                                    SnackBar(
                                      content: const Text(
                                          'Erro ao fazer login com Google!'),
                                    ),
                                  );
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen()),
                                );
                              },
                              child: Row(
                                children: <Widget>[
                                  Image.asset(
                                    'images/google_logo.png',
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width /
                                                3.5),
                                    child: Text(
                                      'Google',
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            child: RaisedButton(
                              color: Color(0xFF3B5998),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              onPressed: () {},
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    FontAwesomeIcons.facebook,
                                    color: Colors.white,
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3.5),
                                      child: const Text(
                                        'Facebook',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.0,
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 60.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Align(
                                alignment: Alignment.center,
                                child: const Text(
                                  'Não tem uma conta no PandaPay? ',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
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
