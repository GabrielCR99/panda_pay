import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:pandapay/models/user_model.dart';
import 'package:pandapay/screens/home_screen.dart';
import 'package:pandapay/screens/signup/sign_up_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  List<Slide> slides = new List();

  @override
  void initState() {
    super.initState();

    slides.add(
      Slide(
        title: 'Pague sem sair de casa',
        description:
            'Contas, boletos, recargas e muito mais. Tudo isso apenas com a tecnologia de pagamento'
            ' QR Code.',
        pathImage: 'images/qr-code-phone.png',
        backgroundColor: Color(0xff7BAEBC),
        maxLineTitle: 1,
      ),
    );
    slides.add(
      Slide(
        title: 'Sem taxas abusivas',
        description:
            'Cansado de pagar taxas com valores altos para tudo, sem entender o por quê?'
            ' Então o PandaPay é pra você!',
        pathImage: 'images/abusive_tax.jpg',
        backgroundColor: Color(0xff7BAEBC),
        maxLineTitle: 1,
      ),
    );
    slides.add(
      Slide(
        title: 'Transferências instantâneas',
        description:
            'Transfira ilimitadamente, a hora que quiser e sem taxas. Garantimos a segurança'
            ' com a tecnologia Blockchain.',
        pathImage: 'images/mobile_transfer.png',
        backgroundColor: Color(0xff7BAEBC),
        maxLineTitle: 2,
      ),
    );
    slides.add(
      Slide(
        backgroundColor: Color(0xff7BAEBC),
        title: 'Curtiu, né?',
        description: 'Então, faça parte do PandaPay e peça já o seu PandaCard!',
        pathImage: 'images/happy_panda.png',
        maxLineTitle: 1,
      ),
    );
  }

  void onDonePress() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => SignUpScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(
      builder: (BuildContext context, Widget child, UserModel model) {
        if (!model.isLoggedIn())
          return IntroSlider(
            slides: this.slides,
            onDonePress: this.onDonePress,
            nameNextBtn: 'Avançar',
            namePrevBtn: 'Voltar',
            nameSkipBtn: 'Pular',
            nameDoneBtn: 'Criar conta',
          );
        return HomeScreen();
      },
    );
  }
}
