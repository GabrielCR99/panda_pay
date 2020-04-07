import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pandapay/models/user_model.dart';
import 'package:pandapay/screens/sign_in_screen.dart';
import 'package:pandapay/widgets/input_field.dart';
import 'package:scoped_model/scoped_model.dart';

class PasswordRecovery extends StatefulWidget {
  @override
  _PasswordRecoveryState createState() => _PasswordRecoveryState();
}

class _PasswordRecoveryState extends State<PasswordRecovery> {
  final TextEditingController _emailController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Row(
          children: <Widget>[
            Image.asset(
              'images/PandaPay_Horizontal_SemSlogan_Black.png',
              fit: BoxFit.cover,
              height: 35.0,
            ),
          ],
        ),
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (BuildContext context, Widget child, UserModel model) {
          return Form(
            key: _formKey,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  color: Colors.white,
                ),
                SingleChildScrollView(
                  child: Container(
                    color: Colors.white,
                    margin: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: const Text(
                            'Oh não :(',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.w600),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Image.asset(
                          'images/sad_panda.png',
                          height: 150,
                          width: 150,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: const Text(
                            'O panda sente muito que voce esqueceu sua senha. '
                            'Mas, fique tranquilo, a gente vai resolver ;) \n'
                            'Basta você inserir qual o E-mail que utilizou',
                            textAlign: TextAlign.justify,
                            style: TextStyle(fontWeight: FontWeight.w400),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        InputField(
                          textCapitalization: TextCapitalization.none,
                          suffixIcon: Icon(Icons.email),
                          keyboardType: TextInputType.emailAddress,
                          validateText: (email) {
                            if (email.isEmpty ||
                                !email.contains(RegExp(
                                    r"^(([^<>()[\]\\.,;:\s@\']+(\.[^<>()[\]\\.,;:\s@\']+)*)|(\'.+\'))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$")))
                              return 'E-mail inválido!';
                            return null;
                          },
                          controller: _emailController,
                          isObscure: false,
                          icon: Icons.email,
                          labelText: 'E-mail',
                          hint: 'O E-mail cadastrado no app',
                        ),
                        const SizedBox(height: 16),
                        RaisedButton(
                          color: Colors.blueGrey,
                          onPressed: () {
                            if (_formKey.currentState.validate())
                              model.sendPasswordRecovery(
                                  _emailController.text, _onSuccess,
                                  (errorMessage) {
                                _onError(errorMessage);
                                return null;
                              });
                          },
                          child: Text(
                            'Enviar',
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  void _onSuccess() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        'E-mail enviado com sucesso!',
      ),
      backgroundColor: Colors.green[400],
      duration: Duration(seconds: 2),
    ));
    Future.delayed(Duration(seconds: 2)).then((_) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginScreen()));
    });
  }

  void _onError(String errorMessage) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        'Erro ao enviar E-mail! $errorMessage',
      ),
      backgroundColor: Colors.red[400],
      duration: Duration(seconds: 3),
    ));
  }
}
