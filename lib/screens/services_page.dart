import 'package:flutter/material.dart';
import 'package:nossosus_app/shared/themes/app_colors.dart';
import 'package:nossosus_app/shared/themes/app_images.dart';
import 'package:nossosus_app/widgets/bottom_bar_widget.dart';
import 'package:nossosus_app/widgets/larger_card_widget.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({Key? key}) : super(key: key);

  @override
  _ServicesPageState createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  TextEditingController editingController = TextEditingController();
  List cards = [
    {
      'contentPaddingLeft': 15.0,
      'icon': const Icon(
        Icons.favorite,
        size: 40.0,
        color: Color(0xFFAD2626),
      ),
      'title': 'Serviços SUS',
      'route-page': '/map',
    },
    {
      'contentPaddingLeft': 15.0,
      'icon': Image.asset(
        AppImages.susLogo,
        height: 40,
      ),
      'title': 'Informações sobre o SUS',
      'route-page': '/sus-atendimento',
    },
    {
      'contentPaddingLeft': 0.0,
      'icon': Image.asset(
        AppImages.iconCardSus,
      ),
      'title': 'Como obter meu Cartão SUS?',
      'route-page': '/card-sus',
    },
  ];
  List cardsFilters = [];

  @override
  initState() {
    super.initState();
    cardsFilters.addAll(cards);
  }

  _cardsFilter(String filter) {
    cardsFilters.clear();
    for (Map i in cards) {
      if (i['title'].toLowerCase().contains(filter.toLowerCase())) {
        cardsFilters.add(i);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Serviços'),
      ),
      body: Column(
        children: [
          _buildSearchField(),
          Expanded(
            child: ListView.builder(
              itemCount: cardsFilters.length,
              padding: const EdgeInsets.only(top: 10.0),
              itemBuilder: (context, index) {
                dynamic cardInfo = cardsFilters[index];
                return _buildCard(
                  cardInfo['route-page'],
                  cardInfo['icon'],
                  cardInfo['title'],
                  cardInfo['contentPaddingLeft'],
                );
              },
            ),
          )
        ],
      ),
      bottomNavigationBar: const BottomBarWidget(ButtonSelected.services),
    );
  }

  _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.all(7.0),
      child: TextField(
        onChanged: (text) {
          _cardsFilter(text);
          setState(() {});
        },
        controller: editingController,
        decoration: InputDecoration(
          labelText: "Procurar servicos do app",
          labelStyle: const TextStyle(color: AppColors.primary),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0))),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(
              color: AppColors.primary,
              width: 2.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(
              color: AppColors.primary,
              width: 2.0,
            ),
          ),
        ),
      ),
    );
  }

  _buildCard(routePage, icon, textCard, contentPaddingLeft) {
    return LargerCardWidget(
      onTap: () => Navigator.pushNamed(context, routePage),
      icon: icon,
      textCard: textCard,
      contentPaddingLeft: contentPaddingLeft,
      listTile: true,
    );
  }
}
