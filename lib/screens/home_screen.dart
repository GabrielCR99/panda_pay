import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pandapay/models/user_model.dart';
import 'package:pandapay/screens/sign_in_screen.dart';
import 'package:pandapay/widgets/custom_drawer.dart';
import 'package:scoped_model/scoped_model.dart';

class HomeScreen extends StatelessWidget {
  final PageController _pageController = PageController();
  final int page = 0;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(
      builder: (BuildContext context, Widget child, UserModel model) {
        return PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            Scaffold(
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
                      icon: Icon(Icons.shopping_cart),
                      title: Text('Pedidos'),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.list),
                      title: Text('Produtos'),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.settings),
                      title: Text('Produtos'),
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
              body: LayoutBuilder(
                builder: (_, constraints) {
                  return Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Container(
                          width: constraints.maxWidth,
                          height: constraints.maxHeight * 0.13,
                          color: Colors.grey[800],
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'Sacar',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16.0),
                                  ),
                                  SizedBox(
                                    height: constraints.maxHeight * .09,
                                    width: 40.0,
                                    child: RawMaterialButton(
                                      child: Icon(
                                        Icons.remove_circle,
                                        size: 40.0,
                                        color: Colors.black,
                                      ),
                                      shape: CircleBorder(),
                                      elevation: 6.0,
                                      fillColor: Colors.red,
                                      onPressed: () {},
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: constraints.maxHeight * .01),
                                    child: Text(
                                      'Saldo Total:',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20.0),
                                    ),
                                  ),
                                  SizedBox(height: constraints.maxHeight * .02),
                                  Text(
                                    'R\$ 0,00',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'Adicionar',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16.0),
                                  ),
                                  SizedBox(
                                    height: constraints.maxHeight * .09,
                                    width: 40.0,
                                    child: RawMaterialButton(
                                      child: Icon(
                                        Icons.add_circle,
                                        size: 40.0,
                                        color: Colors.black,
                                      ),
                                      shape: CircleBorder(),
                                      elevation: 6.0,
                                      fillColor: Colors.green,
                                      onPressed: () {},
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: constraints.maxHeight * 0.1),
                      Container(
                        color: Colors.white,
                        height: constraints.maxHeight * .45,
                        width: constraints.maxWidth,
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                left: constraints.maxWidth * .03,
                                right: constraints.maxWidth * .02,
                              ),
                              child: Container(
                                width: constraints.maxWidth * .3,
                                height: constraints.maxHeight * .43,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: constraints.maxHeight * .11,
                                  ),
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Column(
                                      children: <Widget>[
                                        Icon(
                                          FontAwesomeIcons.creditCard,
                                          size: 45,
                                        ),
                                        SizedBox(
                                          height: constraints.maxHeight * .02,
                                        ),
                                        Text(
                                          'Peça já seu cartão!',
                                          maxLines: 2,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  color: Color(0xFF13CE66),
                                  border: Border.all(color: Colors.transparent),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20.0),
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: constraints.maxHeight * .01,
                                  ),
                                  child: Container(
                                    height: constraints.maxHeight * .2,
                                    width: constraints.maxWidth * .3,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        top: constraints.maxHeight * .03,
                                      ),
                                      child: GestureDetector(
                                        onTap: () {},
                                        child: Column(
                                          children: <Widget>[
                                            Icon(
                                              FontAwesomeIcons.mobileAlt,
                                              size: 45,
                                            ),
                                            SizedBox(
                                              height:
                                                  constraints.maxHeight * .02,
                                            ),
                                            Text(
                                              'Carregar celular',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20.0),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: constraints.maxHeight * .025,
                                  ),
                                  child: Container(
                                    height: constraints.maxHeight * .2,
                                    width: constraints.maxWidth * .3,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        top: constraints.maxHeight * .03,
                                      ),
                                      child: GestureDetector(
                                        onTap: () {},
                                        child: Column(
                                          children: <Widget>[
                                            Icon(
                                              FontAwesomeIcons.busAlt,
                                              size: 45,
                                            ),
                                            SizedBox(
                                              height:
                                                  constraints.maxHeight * .01,
                                            ),
                                            Text(
                                              'Carregar Bilhete Único',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.deepOrange,
                                      border: Border.all(
                                        color: Colors.transparent,
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: constraints.maxHeight * .01,
                                      left: constraints.maxWidth * .03),
                                  child: Container(
                                    height: constraints.maxHeight * .2,
                                    width: constraints.maxWidth * .3,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        top: constraints.maxHeight * .03,
                                      ),
                                      child: GestureDetector(
                                        onTap: () {},
                                        child: Column(
                                          children: <Widget>[
                                            Icon(
                                              FontAwesomeIcons.ticketAlt,
                                              size: 45,
                                            ),
                                            SizedBox(
                                              height:
                                                  constraints.maxHeight * .02,
                                            ),
                                            Text(
                                              'Ticket e créditos ',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20.0),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: constraints.maxHeight * .025,
                                      left: constraints.maxWidth * .03),
                                  child: Container(
                                    height: constraints.maxHeight * .2,
                                    width: constraints.maxWidth * .3,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        top: constraints.maxHeight * .03,
                                      ),
                                      child: GestureDetector(
                                        onTap: () {},
                                        child: Column(
                                          children: <Widget>[
                                            Icon(
                                              Icons.headset_mic,
                                              size: 45,
                                            ),
                                            SizedBox(
                                              height:
                                                  constraints.maxHeight * .01,
                                            ),
                                            Text(
                                              'Fale Conosco',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.deepOrange,
                                      border: Border.all(
                                        color: Colors.transparent,
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
