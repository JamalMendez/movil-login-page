import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {

    CollectionReference user = FirebaseFirestore.instance.collection('vendors');
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    String id = firebaseAuth.currentUser!.uid;
    String name = 'businessName';
    String image = 'image';

    if(user.doc(id).get() != null){
      user = FirebaseFirestore.instance.collection('buyers');
      name = 'fullName';
      image = 'profileImage';
    }

    return FutureBuilder<DocumentSnapshot>(
      future: user.doc(id).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 3,
                color: Colors.grey[300],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(data[image].toString()), // Aquí puedes colocar la imagen del usuario
                    ),
                    SizedBox(height: 10),
                    Text(
                      data[name].toString(),
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      data['email'].toString(),
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {

                        },
                        child: Text('Settings'),
                      ),
                      TextButton(
                        onPressed: () {

                        },
                        child: Text('Phone'),
                      ),
                      TextButton(
                        onPressed: () {

                        },
                        child: Text('Cart'),
                      ),
                      TextButton(
                        onPressed: () {

                        },
                        child: Text('Logout'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }

        return const Text("loading");
      },
    );
  }
}
