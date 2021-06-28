import 'package:flutter/material.dart';
import 'package:nossosus_app/shared/themes/app_colors.dart';
import 'package:nossosus_app/shared/themes/app_images.dart';
import 'package:nossosus_app/shared/themes/app_text_styles.dart';

class CardSusPage extends StatelessWidget {
  const CardSusPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Cartão SUS'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Image.asset(AppImages.cardSus),
            SizedBox(height: 20),
            RichText(
              textAlign: TextAlign.justify,
              text: TextSpan(
                style: new TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black),
                children: [
                  TextSpan(
                    text: 'Vá até uma Unidade Básica de Saúde, levando o ',
                  ),
                  TextSpan(
                      text: 'RG',
                      style: TextStyle(
                        color: Colors.blue[900],
                      )),
                  TextSpan(text: ' e '),
                  TextSpan(
                      text: 'CPF',
                      style: TextStyle(
                        color: Colors.blue[900],
                      )),
                  TextSpan(
                      text:
                          '. É impresso na hora, mas caso isso não aconteça, você receberá poucos dias depois. Também é possível fazer o cartão SUS pelo app '),
                  TextSpan(
                      text: 'Conecte SUS',
                      style: TextStyle(
                        color: Colors.blue[400],
                      )),
                  TextSpan(text: '!')
                ],
              ),
            ),
            SizedBox(height: 20),
            Card(
              child: ListTile(
                leading: Icon(Icons.check),
                title: Text('Baixar Conecte SUS',
                    style: TextStyles.titleCardPrimary),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: AppColors.primary,
        height: 56,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.home_outlined),
                  color: AppColors.bottomNotSelect,
                ),
                // Text('Início', style: TextStyles.textAppBar)
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.menu),
                  color: AppColors.bottomSelect,
                ),
                // Text('Serviços', style: TextStyles.textAppBarNS)
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.person),
                  color: AppColors.bottomNotSelect,
                ),
                // Text('Perfil', style: TextStyles.textAppBarNS)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
