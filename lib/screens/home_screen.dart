import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pandapay/models/user_model.dart';
import 'package:pandapay/screens/sign_in_screen.dart';
import 'package:pandapay/widgets/custom_drawer.dart';
import 'package:scoped_model/scoped_model.dart';

class HomeScreen extends StatelessWidget {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(
      builder: (BuildContext context, Widget child, UserModel model) {
        return PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            Scaffold(
              drawer: CustomDrawer(
                pageController: _pageController,
              ),
              appBar: AppBar(
                actions: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(FontAwesomeIcons.bell,size: 30.0,),
                  ),
                ],
                elevation: 0,
                iconTheme: IconThemeData(color: Colors.black),
                backgroundColor: Colors.white,
                title: Row(
                  children: <Widget>[
                    Image.asset(
                      'images/PandaPay_Icone_Black.png',
                      height: 35,
                    ),
                    const VerticalDivider(width: 15.0),
                    Text(
                      'Olá, ${!model.isLoggedIn() ? '' : model.userData['name']}',
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    GestureDetector(
                      child: Text(
                        'Sair',
                        style: TextStyle(fontSize: 18.0, color: Colors.black),
                      ),
                      onTap: () {
                        model.signOut();
                        Navigator.of(context).pop();
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) => LoginScreen()));
                      },
                    ),
                  ],
                ),
              ),
              body: Container(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Container(
                    height: 60.0,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
