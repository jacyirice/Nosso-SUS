import 'package:flutter/material.dart';
import 'package:nossosus_app/shared/themes/app_images.dart';
import 'package:nossosus_app/widgets/bottom_bar_widget.dart';
import 'package:nossosus_app/widgets/larger_card_widget.dart';

class SusAtendimentoPage extends StatelessWidget {
  const SusAtendimentoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Documentação'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Image.asset(AppImages.cardSus),
            const SizedBox(height: 20),
            const Text(
              'Para ser atendido leve os seguintes documentos:'
              '\n\n• Documento de identificação com foto'
              '\n\n• Cartão do SUS',
              textAlign: TextAlign.left,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildCard(context),
          ],
        ),
      ),
      bottomNavigationBar: const BottomBarWidget(ButtonSelected.services),
    );
  }

  _buildCard(context) {
    return LargerCardWidget(
      onTap: () => Navigator.pushNamed(context, '/card-sus'),
      icon: Image.asset(
        AppImages.iconCardSus,
        height: 71,
      ),
      textCard: 'Como obter meu Cartão SUS?',
    );
  }
}
