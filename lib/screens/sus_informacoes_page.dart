import 'package:flutter/material.dart';
import 'package:nossosus_app/shared/themes/app_images.dart';
import 'package:nossosus_app/shared/themes/app_text_styles.dart';

import 'bottomBar.dart';

class SusAtendimentoPage extends StatelessWidget {
  const SusAtendimentoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Documentação'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Image.asset(AppImages.cardSus),
            SizedBox(height: 20),
            Text(
              'Para ser atendido leve os seguintes documentos:\n\n• Documento de identificação com foto\n\n• Cartão do SUS',
              textAlign: TextAlign.left,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Container(
              height: 71,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/card-sus');
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        AppImages.iconCardSus,
                        height: 71,
                      ),
                      Container(
                        width: 225,
                        child: Text(
                          'Como obter meu Cartão SUS?',
                          style: TextStyles.titleCardPrimary,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppBottom(
        activeBottom: 1,
      ),
    );
  }
}
