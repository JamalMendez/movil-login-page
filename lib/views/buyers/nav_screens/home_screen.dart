import 'package:flutter/material.dart';
import 'package:login_page/views/buyers/widgets/banner_widget.dart';
import 'package:login_page/views/buyers/widgets/category_item.dart';
import 'package:login_page/views/buyers/widgets/header_screen.dart';
import 'package:login_page/views/buyers/widgets/product_widget.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Header_Screen(),
          BannerWidget(),
          CategoryItem(),
          ProductWidget(),
        ],
      ),
    );
  }
}
