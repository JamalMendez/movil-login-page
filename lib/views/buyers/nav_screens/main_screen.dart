import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_page/views/buyers/nav_screens/account_screen.dart';
import 'package:login_page/views/buyers/nav_screens/car_screen.dart';
import 'package:login_page/views/buyers/nav_screens/category_screen.dart';
import 'package:login_page/views/buyers/nav_screens/home_screen.dart';
import 'package:login_page/views/buyers/nav_screens/store_screen.dart';


class MainScreen extends StatefulWidget {
  const MainScreen ({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override

  int _currentPage = 0;
  List<Widget> _pages = [
    HomeScreen(),
    CategoryScreen(),
    StoreScreen(),
    CarScreen(),
    //SearchScreen(),
    AScreen()
  ];
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.deepPurpleAccent,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentPage,
          onTap: (value){
          setState(() {
            print(value);
            _currentPage = value;
          });
          },
        items: [
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.home),
          label: 'Home'
          ),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.star),
              label: 'Favorites'
          ),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.bag_fill),
              label: 'Store'
          ),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.shopping_cart),
              label: 'Car'
          ),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.person),
              label: 'Account'
          ),
        ],
      ),
      body: _pages[_currentPage],
    );
  }
}
