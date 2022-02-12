import 'package:flutter/material.dart';
import 'package:nossosus_app/screens/search_page.dart';
import 'package:nossosus_app/shared/themes/app_colors.dart';
import 'package:nossosus_app/shared/themes/app_images.dart';
import 'package:nossosus_app/shared/themes/app_text_styles.dart';
import 'package:nossosus_app/widgets/bottom_bar_widget.dart';
import 'package:nossosus_app/widgets/larger_card_widget.dart';
import 'package:nossosus_app/widgets/square_card_widget.dart';
import 'package:nossosus_app/widgets/title_category_card_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _myControllerSearch = TextEditingController();
  List cardSecundary = [
    {
      'icon': const Icon(
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
      appBar: _buildAppBar(),
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(23.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TitleCategoryCardWidget('Cartão SUS'),
            const SizedBox(height: 16),
            _buildCardCartaoSUS(),
            const SizedBox(height: 16),
            const TitleCategoryCardWidget('Acesso rápido'),
            _buildCardsSecundarys(),
          ],
        ),
      ),
      bottomNavigationBar: const BottomBarWidget(ButtonSelected.home),
    );
  }

  _buildSearchField() {
    return TextField(
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
            borderSide: const BorderSide(width: 32.0),
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
    );
  }

  _buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(182),
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
              _buildSearchField(),
            ],
          ),
        ),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(67.0),
          ),
        ),
      ),
    );
  }

  _buildCardCartaoSUS() {
    return LargerCardWidget(
      onTap: () {
        Navigator.pushNamed(context, '/card-sus');
      },
      icon: Image.asset(
        AppImages.iconCardSus,
        height: 71,
      ),
      textCard: 'Como obter meu Cartão SUS?',
    );
  }

  _buildCardsSecundarys() {
    return Expanded(
      child: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 24,
          crossAxisSpacing: 40,
          crossAxisCount: 2,
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 2),
        ),
        itemCount: cardSecundary.length,
        itemBuilder: (context, index) {
          return SquareCardWidget(
              onTap: () => Navigator.pushNamed(
                    context,
                    cardSecundary[index]['route-page'],
                  ),
              icon: cardSecundary[index]['icon'],
              textCard: cardSecundary[index]['title']);
        },
      ),
    );
  }
}
