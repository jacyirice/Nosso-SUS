import 'package:flutter/material.dart';
import 'package:nossosus_app/screens/search_page.dart';
import 'package:nossosus_app/shared/themes/app_colors.dart';
import 'package:nossosus_app/shared/themes/app_images.dart';
import 'package:nossosus_app/shared/themes/app_text_styles.dart';

import 'bottom_bar.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _myControllerSearch = TextEditingController();
  List cardSecundary = [
    {
      'icon': Icon(
        Icons.favorite,
        size: 40.0,
        color: Color(0xFFAD2626),
      ),
      'title': 'Serviços SUS',
      'route-page': '/map',
    },
    {
      'icon': Image.asset(
        AppImages.iconInfoSus,
        height: 40,
      ),
      'title': 'Informações sobre o SUS',
      'route-page': '/sus-atendimento',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(182),
        child: Container(
          height: 182,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ListTile(
                  title: Text(
                    'Seja bem-vindo',
                    style: TextStyles.titleRegular,
                  ),
                ),
                TextField(
                  controller: _myControllerSearch,
                  style: TextStyle(color: AppColors.background),
                  decoration: InputDecoration(
                    hintText: 'O que você procura?',
                    hintStyle: TextStyle(color: AppColors.background),
                    suffixIcon: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SearchPage(
                              search_service: _myControllerSearch.text,
                            ),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.search,
                        color: AppColors.background,
                      ),
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(width: 32.0),
                        borderRadius: BorderRadius.circular(252.0)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(252.0),
                      borderSide: BorderSide(
                        color: AppColors.background,
                        width: 2.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(252.0),
                      borderSide: BorderSide(
                        color: AppColors.background,
                        width: 2.0,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(67.0),
            ),
          ),
        ),
      ),
      backgroundColor: AppColors.background,
      body: Padding(
        padding: EdgeInsets.all(23.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Cartão SUS', style: TextStyles.titleCategoryCard),
            SizedBox(height: 16),
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
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(.5),
                    blurRadius: 20.0,
                    offset: Offset(20.0, 10.0),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Text('Acesso rápido', style: TextStyles.titleCategoryCard),
            Expanded(
              child: GridView.builder(
                  padding: EdgeInsets.all(12),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 24,
                    crossAxisSpacing: 40,
                    crossAxisCount: 2,
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height / 2),
                  ),
                  itemCount: cardSecundary.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 82,
                      width: 131,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, cardSecundary[index]['route-page']);
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                cardSecundary[index]['icon'],
                                Text(
                                  cardSecundary[index]['title'],
                                  style: TextStyles.titleCardPrimary,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
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
                  }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(
        activeBottom: 0,
      ),
    );
  }
}
