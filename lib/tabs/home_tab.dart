import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pandapay/models/user_model.dart';
import 'package:pandapay/widgets/custom_drawer.dart';
import 'package:scoped_model/scoped_model.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(
      builder: (context, child, model) {
        return Scaffold(
          drawer: CustomDrawer(),
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
                                      color: Colors.white,
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
                              color: Color(0xFF474747),
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
                                          color: Colors.white,
                                          size: 45,
                                        ),
                                        SizedBox(
                                          height: constraints.maxHeight * .02,
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
                                  color: Color(0xFF0851A9),
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
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          height: constraints.maxHeight * .01,
                                        ),
                                        Text(
                                          'Carregar Transporte',
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
                                  color: Color(0xFFcf0000),
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
                                          height: constraints.maxHeight * .02,
                                        ),
                                        Text(
                                          'Voucher e créditos ',
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
                                  color: Color(0xFFEDBE2F),
                                  border: Border.all(
                                    color: Colors.transparent,
                                  ),
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
                                          height: constraints.maxHeight * .01,
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
                                  color: Color(0xFF13CE67),
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
                  SizedBox(
                    height: constraints.maxHeight * .05,
                  ),
                  Container(
                    color: Color(0xFFF5F5F5),
                    height: 100,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: constraints.maxWidth * .03,
                      ),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.mobileAlt,
                            size: 45,
                          ),
                          Container(
                            width: 335,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, top: 16, right: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Traga seus amigos e transfira ilimitadamente!',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                  Text(
                                    'Transferências entre usuários PandaPay são grátis '
                                    'e não dependem do horário bancário. Quantas vezes quiser e quando quiser.',
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
