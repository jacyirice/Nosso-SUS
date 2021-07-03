import 'package:flutter/material.dart';
import 'package:nossosus_app/shared/themes/app_colors.dart';
import 'package:nossosus_app/shared/themes/app_images.dart';
import 'package:nossosus_app/shared/themes/app_text_styles.dart';

import 'bottom_bar.dart';

class ServicesPage extends StatefulWidget {
  ServicesPage({Key? key}) : super(key: key);

  @override
  _ServicesPageState createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  TextEditingController editingController = TextEditingController();
  List cards = [
    {
      'contentPaddingLeft': 15.0,
      'icon': Icon(
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

  cardsFilter(filter) {
    cardsFilters.clear();
    for (Map i in cards) {
      if (i['title'].toLowerCase().contains(filter)) cardsFilters.add(i);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Serviços'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(7.0),
            child: TextField(
              controller: editingController,
              decoration: InputDecoration(
                labelText: "Procurar servicos do app",
                labelStyle: TextStyle(color: AppColors.primary),
                suffixIcon: IconButton(
                    icon: Icon(
                      Icons.search,
                      color: AppColors.primary,
                    ),
                    onPressed: () {
                      cardsFilter(editingController.text);
                      setState(() {});
                    }),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0))),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color: AppColors.primary,
                    width: 2.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color: AppColors.primary,
                    width: 2.0,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cardsFilters.length,
              padding: EdgeInsets.only(top: 10.0),
              itemBuilder: (context, index) {
                return Container(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                          context, cardsFilters[index]['route-page']);
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.only(
                          left: cardsFilters[index]['contentPaddingLeft'],
                        ),
                        leading: cardsFilters[index]['icon'],
                        title: Text(cardsFilters[index]['title'],
                            style: TextStyles.titleCardPrimary),
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(.5),
                        blurRadius: 20.0,
                        offset: Offset(20.0, 10.0),
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
      bottomNavigationBar: AppBottom(
        activeBottom: 1,
      ),
    );
  }
}
