import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pandapay/widgets/input_field.dart';

class PasswordRecovery extends StatefulWidget {
  @override
  _PasswordRecoveryState createState() => _PasswordRecoveryState();
}

class _PasswordRecoveryState extends State<PasswordRecovery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Form(
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
                    const Text(
                      'Oh não :(',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 16),
                    Image.asset(
                      'images/sad_panda.png',
                      height: 150,
                      width: 150,
                    ),
                    const Text(
                      'O panda ficou triste que voce esqueceu sua senha. '
                      'Mas, fique tranquilo, a gente vai resolver ;) \n'
                      'Basta você inserir qual o E-mail que utilizou',
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 16.0),
                    InputField(
                      isObscure: false,
                      icon: Icons.email,
                      labelText: 'Login',
                      hint: 'E-mail ou CPF/CNPJ',
                    ),
                    const SizedBox(height: 16),

                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
