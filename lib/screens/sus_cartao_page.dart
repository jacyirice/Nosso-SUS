import 'package:flutter/material.dart';
import 'package:nossosus_app/shared/themes/app_images.dart';
import 'package:nossosus_app/shared/themes/app_text_styles.dart';
import 'package:nossosus_app/widgets/bottom_bar_widget.dart';
import 'package:nossosus_app/widgets/larger_card_widget.dart';

import 'package:url_launcher/url_launcher.dart';

const String urlGooglePlayConnectSUS =
    'https://play.google.com/store/apps/details?id=br.gov.datasus.cnsdigital&hl=pt_BR&gl=US';

class CardSusPage extends StatelessWidget {
  const CardSusPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Cartão SUS'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Image.asset(AppImages.cardSus),
            const SizedBox(height: 20),
            _buildRichText(),
            const SizedBox(height: 20),
            _buildCard(),
          ],
        ),
      ),
      bottomNavigationBar: const BottomBarWidget(ButtonSelected.services),
    );
  }

  _buildRichText() {
    return RichText(
      textAlign: TextAlign.justify,
      text: TextSpan(
        style:
            const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        children: [
          const TextSpan(
            text: 'Vá até uma Unidade Básica de Saúde, levando o ',
          ),
          TextSpan(
              text: 'RG',
              style: TextStyle(
                color: Colors.blue[900],
              )),
          const TextSpan(text: ' e '),
          TextSpan(
              text: 'CPF',
              style: TextStyle(
                color: Colors.blue[900],
              )),
          const TextSpan(
              text:
                  '. É impresso na hora, mas caso isso não aconteça, você receberá poucos dias depois. Também é possível fazer o cartão SUS pelo app '),
          TextSpan(
              text: 'Conecte SUS',
              style: TextStyle(
                color: Colors.blue[400],
              )),
          const TextSpan(text: '!')
        ],
      ),
    );
  }

  _buildCard() {
    return LargerCardWidget(
      onTap: () => _launchURL(urlGooglePlayConnectSUS),
      icon: Image.asset(
        AppImages.iconConecteSus,
        height: 71,
      ),
      textCard: 'Baixar Conecte SUS',
    );
  }
}

_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Não foi possivel abrir $url';
  }
}
