import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:quidditch_app/widgets/widgets.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);
  static Widget create(BuildContext context) => IntroScreen();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("QuidditchApp"),
      ),
      body: Center(
        child: _IntroPage(),
      ),
    );
  }
}

class _IntroPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return PageIndicatorContainer(
      child: PageView(
        children: const [
          DescriptionView(
            textView:
                "Esta aplicacion esta creada por Diego A. Bagato Segoviano. \nEs una aplicacion Demo para el Proyecto final de 2ºDAW Sin animos lucrativos",
            imagePath: "assets/images/quidditchAppLogo.jpeg",
            heightImage: 200,
            widthImage: 200,
          ),
          DescriptionView(
            textView: "Puede conectarse con su red de preferencia",
            imagePath: "assets/images/pantallaLogin.png",
            heightImage: 400,
            widthImage: 300,
          ),
          DescriptionView(
            textView:
                "O bien en caso de no tener cuenta se le solicitara una cuenta para poder conectarse.\nPuede rellenar el formulario con su correo para poder conectarse",
            imagePath: "assets/images/pantallaCreateAccount.png",
            heightImage: 400,
            widthImage: 300,
          ),
          LoginView(
              text: "Registrate o Crea tu cuenta en QuidditchApp",
              imagePath: "assets/images/quidditchAppLogo.jpeg"),
        ],
      ),
      length: 4,
      indicatorSpace: 12,
    );
  }
}
