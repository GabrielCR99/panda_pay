import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pandapay/models/user_model.dart';
import 'package:pandapay/widgets/input_field.dart';
import 'package:scoped_model/scoped_model.dart';

class SettingsTab extends StatefulWidget {
  @override
  _SettingsTabState createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
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
                        image: AssetImage('images/person.png'),
                        fit: BoxFit.cover),
                  ),
                ),
                onTap: () {
                },
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Nome',
                ),
                textCapitalization: TextCapitalization.sentences,
              ),
              InputField(
                keyboardType: TextInputType.text,
                suffixIcon: Icon(Icons.person),
                isObscure: false,
                hint: 'Nome',

              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Phone',
                ),
                onChanged: (text) {
                },
                keyboardType: TextInputType.phone,
              ),
            ],
          ),
        );
      },
    );
  }
}
