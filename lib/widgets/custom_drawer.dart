import 'package:flutter/material.dart';
import 'package:pandapay/models/user_model.dart';
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
                            backgroundImage: model.userData['picture'] != null
                                ? NetworkImage(
                                    'https://www.facebook.com/photo?fbid=1909020575797406&set=a.150006515032163')
                                : AssetImage('images/person.png'),
                          ),
                          accountName: Text('${model.userData['name']}'),
                          accountEmail: Text('${model.userData['email']}'),
                        ),
                        const Divider(height: 20.0),
                        DrawerTile(Icons.home, 'Meu cartão', pageController, 0),
                        DrawerTile(
                            Icons.verified_user, 'Teste', pageController, 1),
                        DrawerTile(Icons.home, 'Teste', pageController, 2),
                        DrawerTile(Icons.home, 'Teste', pageController, 3),
                        const Divider(color: Colors.grey),
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
