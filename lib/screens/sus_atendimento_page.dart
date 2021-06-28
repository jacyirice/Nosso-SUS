import 'package:flutter/material.dart';
import 'package:nossosus_app/shared/themes/app_colors.dart';
import 'package:nossosus_app/shared/themes/app_images.dart';
import 'package:nossosus_app/shared/themes/app_text_styles.dart';

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
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Image.asset(AppImages.cardSus),
            SizedBox(height: 20),
            Text(
                'Para ser atendido leve os seguintes documentos:\n\n• Documento de identificação com foto\n\n• Cartão do SUS',
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/card-sus');
              },
              child: Card(
                child: ListTile(
                  leading: Icon(Icons.check),
                  title: Text('Como obter meu Cartão SUS?',
                      style: TextStyles.titleCardPrimary),
                ),
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
