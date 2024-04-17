import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_page/Vendors/model/vendor_model.dart';
import 'package:login_page/Vendors/views/auth/vendor_registration_screen.dart';
import 'package:login_page/Vendors/views/vendor_screens/main_vendor_screen.dart';



class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final CollectionReference _vendorsStream = FirebaseFirestore.instance.collection('vendors');

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: _vendorsStream.doc(_auth.currentUser!.uid).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }
        //Revisamos si el vendedor completo el usuario de registro
        if(!snapshot.data!.exists){
          return const VendorRegistrationScreen();
        }
        VendorModel vendorModel = VendorModel.fromJson(
          snapshot.data!.data() as Map<String, dynamic>
        );
        if(vendorModel.approve == true){
          return const MainVendorScreen();
        }
        //Si llega a este punto, implica que no esta aprovado aun y mostramos un landing
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(vendorModel.image,
                width: 90,
                fit: BoxFit.cover,),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(vendorModel.businessName.toUpperCase(),
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold
              ),
              ),
              const Text("Your profile was sent for Approval"),
            ],
          ),
        );
      },
    );
  }
}
