import 'package:brasil_fields/brasil_fields.dart';
import 'package:cpfcnpj/cpfcnpj.dart';
import 'package:encrypt/encrypt.dart' as keyUtf;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pandapay/models/business_type_model.dart';
import 'package:pandapay/models/user_model.dart';
import 'package:pandapay/screens/home_screen.dart';
import 'package:pandapay/screens/sign_in_screen.dart';
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
  final _confirmPasswordController = TextEditingController();
  final _emailController = TextEditingController();
  final _cpfController = TextEditingController();
  final _codeController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String verificationId;

  /// Sends the code to the specified phone number.
  /// Still needs to get smsCode

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
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        FormField<OrderBy>(
                          initialValue: OrderBy.TO_ME,
                          builder: (FormFieldState state) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      state.didChange(OrderBy.TO_ME);
                                      _typeModel.orderBy = state.value;
                                      _cpfController.text = '';
                                    });
                                  },
                                  child: Container(
                                    child: Text(
                                      'PARA MIM',
                                      style: TextStyle(
                                        color: state.value == OrderBy.TO_ME
                                            ? Colors.white
                                            : Colors.grey,
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                    width: 160,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: state.value == OrderBy.TO_ME
                                          ? Color(0xFF13CE66)
                                          : Colors.white,
                                      border: Border.all(
                                          color: state.value == OrderBy.TO_ME
                                              ? Colors.transparent
                                              : Colors.grey),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(50.0),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 40.0),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      state.didChange(OrderBy.TO_MY_BUSINESS);
                                      _typeModel.orderBy = state.value;
                                      _cpfController.text = '';
                                    });
                                  },
                                  child: Container(
                                    child: Text(
                                      'PARA MEU NEGÓCIO',
                                      style: TextStyle(
                                        color: state.value ==
                                                OrderBy.TO_MY_BUSINESS
                                            ? Colors.white
                                            : Colors.grey,
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                    width: 160,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color:
                                          state.value == OrderBy.TO_MY_BUSINESS
                                              ? Color(0xFF13CE66)
                                              : Colors.white,
                                      border: Border.all(
                                          color: state.value ==
                                                  OrderBy.TO_MY_BUSINESS
                                              ? Colors.transparent
                                              : Colors.grey),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(50.0),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 20.0),
                        InputField(
                          textCapitalization: TextCapitalization.words,
                          controller: _nameController,
                          isObscure: false,
                          suffixIcon: _typeModel.orderBy == OrderBy.TO_ME
                              ? Icon(Icons.person)
                              : Icon(Icons.account_balance),
                          labelText:
                              '${_typeModel.orderBy == OrderBy.TO_ME ? 'Nome' : 'Razão Social'}',
                          hint:
                              '${_typeModel.orderBy == OrderBy.TO_ME ? 'O nome que está no seu RG' : 'O nome da sua empresa'}',
                          validateText: (name) {
                            if (name.isEmpty) return 'Campo obrigatório!';
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
                          validateText: (email) {
                            if (email.isEmpty ||
                                !email.contains(RegExp(
                                    r"^(([^<>()[\]\\.,;:\s@\']+(\.[^<>()[\]\\.,;:\s@\']+)*)|(\'.+\'))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$")))
                              return 'E-mail inválido!';
                            return null;
                          },
                        ),
                        const SizedBox(height: 16.0),
                        InputField(
                          textCapitalization: TextCapitalization.none,
                          controller: _cpfController,
                          suffixIcon: Icon(FontAwesomeIcons.idCard),
                          labelText:
                              '${_typeModel.orderBy == OrderBy.TO_ME ? 'CPF' : 'CNPJ'}',
                          hint:
                              '${_typeModel.orderBy == OrderBy.TO_ME ? '000.000.000-00' : '00.000.000/0000-00'}',
                          isObscure: false,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            WhitelistingTextInputFormatter.digitsOnly,
                            _typeModel.orderBy == OrderBy.TO_ME
                                ? CpfInputFormatter()
                                : CnpjInputFormatter(),
                          ],
                          validateText: (cpf) {
                            if (cpf.isEmpty ||
                                (!CPF.isValid(cpf) &&
                                    _typeModel.orderBy == OrderBy.TO_ME) ||
                                (!CNPJ.isValid(cpf) &&
                                    _typeModel.orderBy ==
                                        OrderBy.TO_MY_BUSINESS))
                              return 'CPF/CNPJ inválido!';
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
                            if (password.isEmpty) return 'Senha obrigatória!';
                            if (password.length <= 6)
                              return 'A senha deve conter mais de 6 caracteres!';
                            return null;
                          },
                        ),
                        const SizedBox(height: 16.0),
                        InputField(
                          textCapitalization: TextCapitalization.none,
                          suffixIcon: Icon(Icons.lock),
                          isObscure: true,
                          controller: _confirmPasswordController,
                          labelText: 'Confirmar senha',
                          hint: 'Repita a senha',
                          validateText: (password) {
                            if (password.isEmpty ||
                                !password.contains(_passwordController.text))
                              return 'Senha não confere!';
                            else if (password.length <= 6)
                              return 'A senha deve conter mais de 6 caracteres!';
                            return null;
                          },
                        ),
                        const SizedBox(height: 16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: 250,
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
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width / 4,
                                height: 50,
                                child: RaisedButton(
                                  disabledColor: Colors.blueGrey.withAlpha(150),
                                  onPressed: () => _sendCodeToPhoneNumber(),
                                  color: Colors.blueGrey,
                                  child: Text(
                                    'Verificar',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: <Widget>[
                            Container(
                              width: 250,
                              child: TextFormField(
                                controller: _codeController,
                                maxLength: 6,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(6)
                                ],
                                keyboardType: TextInputType.number,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  counterText: '',
                                  suffixIcon: Icon(Icons.check_circle),
                                  hintText: 'XXXXXX',
                                  labelText: 'Código de confirmação',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                                validator: (code) {
                                  if (code.isEmpty || !code.contains(''))
                                    return 'Codigo inválido';
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Container(
                          height: 50,
                          child: SizedBox(
                            child: RaisedButton(
                              color: Colors.blueGrey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              onPressed: () {
                                print(_typeModel.orderBy);
                                print(_nameController);
                                print(_passwordController.text.length < 6);
                                if (_formKey.currentState.validate()) {
                                  final key = keyUtf.Key.fromUtf8(
                                      'my 32 length key................');
                                  final iv = keyUtf.IV.fromLength(16);
                                  final encrypt =
                                      keyUtf.Encrypter(keyUtf.AES(key));
                                  print('Validação ok');
                                  final encrypted = encrypt.encrypt(
                                      _passwordController.text,
                                      iv: iv);

                                  Map<String, dynamic> userData = {
                                    'name': _nameController.text,
                                    'email': _emailController.text,
                                    'password': encrypted.base64,
                                    _typeModel.orderBy == OrderBy.TO_ME
                                        ? 'cpf'
                                        : 'cnpj': _cpfController.text,
                                    'phone': _phoneController.text,
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
                                }
                              },
                              child: const Text(
                                'Cadastrar',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16.0),
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
                                      left: MediaQuery.of(context).size.width /
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
                                        left:
                                            MediaQuery.of(context).size.width /
                                                3.5),
                                    child: Text(
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: const Text(
                                  'Já tem uma conta no PandaPay? ',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => LoginScreen(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Entre aqui!',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
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

  ///Sends the SMS code to the user
  /// TODO: verify if TextFormField's code equals smsCode
  Future<void> _sendCodeToPhoneNumber() async {
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential auth) {
      setState(() {
        print(
            'Inside _sendCodeToPhoneNumber: signInWithPhoneNumber auto succeeded: $auth');
      });
    };

    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
      setState(() {
        print(
            'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}');
      });
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      this.verificationId = verificationId;
      print(
          'code sent to ${_phoneController.text.replaceAll('(', '').replaceAll(')', '')} $forceResendingToken');
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      this.verificationId = verificationId;
      print("time out");
      AuthCredential a = PhoneAuthProvider.getCredential(
          verificationId: verificationId, smsCode: '123456');
      print(a.toString().contains('123456'));
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber:
            '+55${_phoneController.text.replaceAll('(', '').replaceAll(')', '')}',
        timeout: const Duration(seconds: 5),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }
}
