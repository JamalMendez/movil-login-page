import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class BannerController extends GetxController {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  
  RxList<String> banners = <String>[].obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _fetchBanners();
  }

  void _fetchBanners(){
    _firebaseFirestore.collection('banners')
        .snapshots()
        .listen((QuerySnapshot querySnapshot){
          banners.assignAll(
            querySnapshot.docs.map((doc){
              print("banners son: " + doc.toString());
              final data = doc.data() as Map<String, dynamic>;
              return data['image'].toString();
            }).toList(),
          );
    });
  }
}