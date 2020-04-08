import 'package:flutter/material.dart';
import 'package:pandapay/models/user_model.dart';
import 'package:pandapay/screens/splash.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          return MaterialApp(
            title: 'PandaPay',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: Splash(),
          );
        },
      ),
    );
  }
}
