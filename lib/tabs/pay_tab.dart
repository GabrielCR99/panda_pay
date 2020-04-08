import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PayTab extends StatefulWidget {
  @override
  _PayTabState createState() => _PayTabState();
}

class _PayTabState extends State<PayTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
              child: Align(
                child: Text(
                  'Pague de maneira fácil!',
                  style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.w600),
                ),
                alignment: Alignment.topCenter,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Utilizando QR Code',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                Icon(
                  FontAwesomeIcons.qrcode,
                  size: 45,
                ),
                Icon(
                  FontAwesomeIcons.camera,
                  size: 45,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Boleto Bancário',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                Icon(
                  FontAwesomeIcons.barcode,
                  size: 45,
                ),
                Icon(
                  FontAwesomeIcons.camera,
                  size: 45,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
