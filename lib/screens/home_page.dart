import 'package:flutter/material.dart';
import 'package:nossosus_app/shared/themes/app_colors.dart';
import 'package:nossosus_app/shared/themes/app_images.dart';
import 'package:nossosus_app/shared/themes/app_text_styles.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List cardSecundary = [
    {
      'icon': Icon(
        Icons.favorite,
        size: 40.0,
        color: Color(0xFFAD2626),
      ),
      'title': 'Serviços SUS'
    },
    {
      'icon': Image.asset(
        AppImages.iconStroke,
        height: 40,
        width: 40,
      ),
      'title': 'Autoavaliar sintomas da COVID-19'
    },
    {
      'icon': Image.asset(
        AppImages.iconCartaoSus,
        height: 80,
      ),
      'title': 'Informações sobre o SUS'
    },
    {
      'icon': Icon(
        Icons.list_alt,
        size: 40.0,
        color: Color(0xFF6A26AD),
      ),
      'title': 'Notícias'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(182),
        child: Container(
          height: 182,
          child: Center(
            child: ListTile(
              title: Text(
                'Seja bem-vindo',
                style: TextStyles.titleRegular,
              ),
            ),
          ),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.only(
              bottomLeft: const Radius.circular(67.0),
            ),
          ),
        ),
      ),
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(23.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Cartão SUS', style: TextStyles.titleCategoryCard),
            SizedBox(height: 16),
            Container(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: ListTile(
                  leading: Icon(Icons.check),
                  title: Text('Como obter meu Cartão SUS?',
                      style: TextStyles.titleCardPrimary),
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
            // SizedBox(height: 6),
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
                  color: AppColors.bottomSelect,
                ),
                Text('Início', style: TextStyles.textAppBar)
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.menu),
                  color: AppColors.bottomNotSelect,
                ),
                Text('Serviços', style: TextStyles.textAppBarNS)
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
                Text('Perfil', style: TextStyles.textAppBarNS)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
