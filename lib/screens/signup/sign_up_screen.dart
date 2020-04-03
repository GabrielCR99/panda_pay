import 'package:brasil_fields/brasil_fields.dart';
import 'package:cpfcnpj/cpfcnpj.dart';
import 'package:encrypt/encrypt.dart' as keyutf;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pandapay/models/business_type_model.dart';
import 'package:pandapay/models/user_model.dart';
import 'package:pandapay/screens/home_screen.dart';
import 'package:pandapay/screens/signup/widgets/business_button.dart';
import 'package:pandapay/widgets/input_field.dart';
import 'package:scoped_model/scoped_model.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  BusinessTypeModel _typeModel = BusinessTypeModel(
    orderBy: OrderBy.TO_ME,
  );
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _cpfController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Image.asset(
                'images/PandaPay_Horizontal_SemSlogan_Black.png',
                fit: BoxFit.cover,
                height: 35.0,
              ),
            ],
          ),
        ),
        body:
            ScopedModelDescendant<UserModel>(builder: (context, child, model) {
          if (model.isLoading)
            return Center(child: CircularProgressIndicator());
          return Form(
            key: _formKey,
            child: Stack(
              children: <Widget>[
                SingleChildScrollView(
                  child: Container(
                    color: Colors.white,
                    margin: const EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        BusinessButtons(initialValue: _typeModel.orderBy),
                        const SizedBox(height: 30.0),
                        InputField(
                          textCapitalization: TextCapitalization.words,
                          controller: _nameController,
                          isObscure: false,
                          suffixIcon: _typeModel.orderBy == OrderBy.TO_ME
                              ? Icon(Icons.person)
                              : Icon(Icons.account_balance),
                          labelText: 'Nome',
                          hint: 'O nome que está no seu RG ',
                          validateText: (name) {
                            if (name.isEmpty) return 'Nome inválido!';
                            return null;
                          },
                        ),
                        const SizedBox(height: 16.0),
                        InputField(
                          textCapitalization: TextCapitalization.none,
                          controller: _emailController,
                          isObscure: false,
                          suffixIcon: Icon(Icons.email),
                          labelText: 'E-mail',
                          hint: 'O E-mail que você mais utiliza',
                          validateText: (name) {
                            if (name.isEmpty) return 'Nome inválido!';
                            return null;
                          },
                        ),
                        const SizedBox(height: 16.0),
                        InputField(
                          textCapitalization: TextCapitalization.none,
                          controller: _cpfController,
                          suffixIcon: Icon(FontAwesomeIcons.idCard),
                          labelText: 'CPF',
                          hint: '000.000.000 - 00',
                          isObscure: false,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            WhitelistingTextInputFormatter.digitsOnly,
                            CpfInputFormatter(),
                          ],
                          validateText: (cpf) {
                            if (cpf.isEmpty || !CPF.isValid(cpf))
                              return 'CPF inválido!';
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
                        const SizedBox(height: 16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: 200,
                              child: InputField(
                                textCapitalization: TextCapitalization.none,
                                controller: _phoneController,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  WhitelistingTextInputFormatter.digitsOnly,
                                  TelefoneInputFormatter(digito_9: true)
                                ],
                                isObscure: false,
                                suffixIcon: Icon(Icons.phone_android),
                                labelText: 'Celular',
                                hint: '(00) 00000-0000',
                                validateText: (phone) {
                                  if (phone.isEmpty ||
                                      !phone.contains(RegExp(
                                          r"\(*0?[1-9]{2}\)* ?(?:[2-8]|9[1-9])[0-9]{3}\-*[0-9]{4}$")))
                                    return 'Celular inválido!';
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Container(
                          child: SizedBox(
                            width: 230.0,
                            child: RaisedButton(
                              color: Colors.blueGrey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  final key = keyutf.Key.fromUtf8(
                                      'my 32 length key................');
                                  final iv = keyutf.IV.fromLength(16);
                                  final encrypter =
                                      keyutf.Encrypter(keyutf.AES(key));
                                  print('Validação ok');
                                  final encrypted = encrypter.encrypt(
                                      _passwordController.text,
                                      iv: iv);

                                  Map<String, dynamic> userData = {
                                    'name': _nameController.text,
                                    'email': _emailController.text,
                                    'password': encrypted.base64,
                                    'cpf': _cpfController.text,
                                    'phone': _phoneController.text,
                                    'corpname': '',
                                  };

                                  model.signUp(
                                    userData: userData,
                                    password: _passwordController.text,
                                    onSuccess: _onSuccess,
                                    onFail: (errorMessage) {
                                      _onFail(errorMessage);
                                      return null;
                                    },
                                  );

                                  print(_cpfController.text);
                                  print(_phoneController.text);
                                }
                              },
                              child: const Text(
                                'Cadastrar',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        const Text(
                          'Cadastrar com:',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        SignInButton(
                          Buttons.Google,
                          text: 'Google',
                          onPressed: () {},
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
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }));
  }

  void _onSuccess() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        'Usuário criado com sucesso!',
      ),
      backgroundColor: Colors.green[400],
      duration: Duration(seconds: 2),
    ));
    Future.delayed(Duration(seconds: 2)).then((_) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen()));
    });
  }

  void _onFail(String errorMessage) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(
          '$errorMessage',
        ),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 3),
      ),
    );
  }
}
