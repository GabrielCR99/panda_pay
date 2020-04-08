import 'package:flutter/material.dart';
import 'package:pandapay/models/user_model.dart';
import 'package:pandapay/screens/sign_in_screen.dart';
import 'package:pandapay/tiles/drawer_tile.dart';
import 'package:scoped_model/scoped_model.dart';

class CustomDrawer extends StatelessWidget {
  final PageController pageController;

  CustomDrawer({Key key, this.pageController});

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(
      builder: (context, child, UserModel model) {
        return Drawer(
          child: Stack(
            children: <Widget>[
              ListView(
                children: <Widget>[
                  Container(
                    child: Column(
                      children: <Widget>[
                        UserAccountsDrawerHeader(
                          currentAccountPicture: CircleAvatar(
                            backgroundImage: AssetImage('images/person.png'),
                          ),
                          accountName: Text(
                              '${model.isLoggedIn() ? '${model.userData == null || model.userData.isEmpty ? '${model.googleName.isEmpty ? model.firebaseUser.displayName : model.googleName}' : model.userData['name']}' : ''}'),
                          accountEmail: Text(
                              '${model.isLoggedIn() ? '${model.userData == null || model.userData.isEmpty ? '${model.googleEmail.isEmpty ? model.firebaseUser.email : model.googleEmail}' : model.userData['email']}' : ''}'),
                        ),
                        const Divider(height: 20.0),
                        DrawerTile(
                            Icons.home, 'Minha carteira', pageController, 0),
                        const Divider(color: Colors.grey),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              model.signOut();
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      LoginScreen(),
                                ),
                              );
                            },
                            child: Container(
                              height: 60.0,
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.exit_to_app,
                                    size: 32.0,
                                  ),
                                  const SizedBox(width: 32.0),
                                  Text(
                                    'Sair',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
