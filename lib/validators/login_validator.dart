import 'dart:async';


class LoginValidator {
  final emailValidator =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    const Pattern pattern =
        r"^(([^<>()[\]\\.,;:\s@\']+(\.[^<>()[\]\\.,;:\s@\']+)*)|(\'.+\'))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$";
    final RegExp regex = RegExp(pattern);
    if (email.isEmpty)
      sink.addError('Campo obrigatório!');
    else if (!regex.hasMatch(email)) sink.addError('E-mail inválido!');
  });

  final passwordValidator =
      StreamTransformer<String, String>.fromHandlers(handleData: (pass, sink) {
    if (pass.isEmpty) sink.addError('Campo obrigatório!');
  });
}
