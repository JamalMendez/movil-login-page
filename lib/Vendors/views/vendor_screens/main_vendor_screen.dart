import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_page/Vendors/views/vendor_screens/vendor_nav_screens/earning_screen.dart';
import 'package:login_page/Vendors/views/vendor_screens/vendor_nav_screens/edit_screen.dart';
import 'package:login_page/Vendors/views/vendor_screens/vendor_nav_screens/logout_screen.dart';
import 'package:login_page/Vendors/views/vendor_screens/vendor_nav_screens/order_screen.dart';
import 'package:login_page/Vendors/views/vendor_screens/vendor_nav_screens/upload_screen.dart';

class MainVendorScreen extends StatefulWidget {

  const MainVendorScreen({super.key});

  @override
  State<MainVendorScreen> createState() => _MainVendorScreenState();
}

class _MainVendorScreenState extends State<MainVendorScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  int _currentPage = 0;
  final List<Widget> _pages = [
    const EarningScreen(),
    const EditScreen(),
    const OrderScreen(),
    //SearchScreen(),
    const UploadScreen(),
    const LogoutScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.deepPurpleAccent,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentPage,
        onTap: (value){
          setState(() {
            _currentPage = value;
            print("current page: $value");
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.home),
              label: 'Earnings'
          ),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.star),
              label: 'Edit'
          ),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.bag_fill),
              label: 'Order'
          ),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.shopping_cart),
              label: 'Upload'
          ),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.person),
              label: 'Logout'
          ),
        ],
      ),
      body: _pages[_currentPage],
    );
  }
}
