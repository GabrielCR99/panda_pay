import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pandapay/models/user_model.dart';
import 'package:pandapay/screens/sign_in_screen.dart';
import 'package:pandapay/tabs/block_chain_tab.dart';
import 'package:pandapay/tabs/home_tab.dart';
import 'package:pandapay/tabs/pay_tab.dart';
import 'package:pandapay/tabs/settings_tab.dart';
import 'package:pandapay/tabs/transfer_tab.dart';
import 'package:pandapay/widgets/custom_drawer.dart';
import 'package:scoped_model/scoped_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _pageController = PageController();
  int page = 0;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(
      builder: (BuildContext context, Widget child, UserModel model) {
        return Scaffold(
          bottomNavigationBar: Theme(
            child: BottomNavigationBar(
              currentIndex: page,
              onTap: (p) {
                _pageController.animateToPage(p,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeIn);
              },
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  title: Text('Início'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.payment),
                  title: Text('Pagar'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.peopleArrows),
                  title: Text('Transferir'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  title: Text('Configurações'),
                )
              ],
            ),
            data: Theme.of(context).copyWith(
              canvasColor: Colors.black,
            ),
          ),
          drawer: CustomDrawer(
            pageController: _pageController,
          ),
          appBar: AppBar(
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(
                  FontAwesomeIcons.bell,
                  size: 30.0,
                ),
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
                  'Olá, ${!model.isLoggedIn() ? '' : ''}',
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
              ],
            ),
          ),
          body: SafeArea(
            child: PageView(
              physics: NeverScrollableScrollPhysics(),
              onPageChanged: (p) {
                setState(() {
                  page = p;
                });
              },
              controller: _pageController,
              children: <Widget>[
                HomTab(),
                PayTab(),
                TransferTab(),
                BlockChainTab(),
                SettingsTab(),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }
}
