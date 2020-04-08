import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pandapay/helpers/user_helper.dart';
import 'package:pandapay/models/user_model.dart';
import 'package:pandapay/widgets/image_source_sheet.dart';
import 'package:pandapay/widgets/input_field.dart';
import 'package:scoped_model/scoped_model.dart';

class SettingsTab extends StatefulWidget {
  final User user;

  SettingsTab({this.user});

  @override
  _SettingsTabState createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  User _editedUserImage;
  UserHelper userHelper = UserHelper();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(
      builder: (BuildContext context, Widget child, UserModel model) {
        return SingleChildScrollView(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              GestureDetector(
                child: Container(
                  width: 140.0,
                  height: 140.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: _editedUserImage.imageName != null
                            ? FileImage(File(_editedUserImage.imageName))
                            : AssetImage('images/person.png'),
                        fit: BoxFit.cover),
                  ),
                ),
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) => ImageSourceSheet(
                            onImageSelected: (image) {
                              Navigator.of(context).pop();
                            },
                          ));
                },
              ),
              InputField(
                keyboardType: TextInputType.text,
                suffixIcon: Icon(Icons.person),
                isObscure: false,
                labelText: 'Nome',
                initialValue:
                    '${model.isLoggedIn() ? '${model.userData == null || model.userData.isEmpty ? '${model.googleName.isEmpty ? model.firebaseUser.displayName : model.googleName}' : model.userData['name']}' : ''}',
                hint: 'O nome que está no seu RG',
                textCapitalization: TextCapitalization.sentences,
              ),
              const SizedBox(height: 16),
              InputField(
                keyboardType: TextInputType.text,
                suffixIcon: Icon(Icons.email),
                isObscure: false,
                labelText: 'E-mail',
                hint: 'E-mail cadastrado no app',
                initialValue:
                    '${model.isLoggedIn() ? '${model.userData == null || model.userData.isEmpty ? '${model.googleEmail.isEmpty ? model.firebaseUser.email : model.googleEmail}' : model.userData['email']}' : ''}',
                textCapitalization: TextCapitalization.none,
              ),
              const SizedBox(height: 16),
              InputField(
                keyboardType: TextInputType.text,
                suffixIcon: Icon(Icons.lock),
                isObscure: true,
                labelText: 'Senha',
                hint: 'Senha do app',
                initialValue:
                    //initialValue set as 'demo' password
                    //TODO: get userPassword from Google Login
                    '${model.userData == null ? '123123' : model.userData['password']}',
                textCapitalization: TextCapitalization.none,
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.user == null) {
      _editedUserImage = User();
    } else {
      _editedUserImage = User.fromMap(widget.user.toMap());
    }
  }
}
