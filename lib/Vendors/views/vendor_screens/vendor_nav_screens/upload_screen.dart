import 'package:flutter/material.dart';
import 'package:login_page/Vendors/views/vendor_screens/tab_screens/upload_tab_screens/atributes_tab_screen.dart';
import 'package:login_page/Vendors/views/vendor_screens/tab_screens/upload_tab_screens/general_tab_screen.dart';
import 'package:login_page/Vendors/views/vendor_screens/tab_screens/upload_tab_screens/images_tab_screen.dart';
import 'package:login_page/Vendors/views/vendor_screens/tab_screens/upload_tab_screens/shipping_tab_screen.dart';

class UploadScreen extends StatelessWidget {
  const UploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text("General"),
              ),
              Tab(
                child: Text("Shipping"),
              ),
              Tab(
                child: Text("Attributes"),
              ),
              Tab(
                child: Text("Images"),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            GeneralTabScreen(),
            AtributesTabScreens(),
            ImagesTabScreen(),
            ShippingTabScreen(),
          ],
        ),
      ),
    );
  }
}
