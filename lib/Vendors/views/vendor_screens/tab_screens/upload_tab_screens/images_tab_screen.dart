import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_page/provider/product_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:file_picker/file_picker.dart';


class ImagesTabScreen extends StatefulWidget {
  const ImagesTabScreen({super.key});

  @override
  State<ImagesTabScreen> createState() => _ImagesTabScreenState();
}

class _ImagesTabScreenState extends State<ImagesTabScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  List<Uint8List?> _image = [];
  List<String> _imageUrls = [];

  final List<XFile?> images = [];

  _pickImage() async {
    final _picker = ImagePicker();
    final List<XFile?> images = await _picker.pickMultiImage();
    if (images.isNotEmpty) {
      setState(() async {
        for (var image in images) {
          if (image != null) {
            // Read image bytes (replace with your logic)
            final bytes = await image.readAsBytes();
            setState(() {
              _image.add(bytes);
            });
          }
        }
      });
    }
  }

  _uploadProductsImagesToStorage() async {
    for (var image in _image) {
      Reference ref =
          _firebaseStorage.ref().child('storeImage').child(Uuid().v4());
      await ref.putData(image!).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          setState(() {
            _imageUrls.add(value);
          });
        });
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    ProductProvider _productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      body: Column(
        children: [
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: _image.length + 1,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return index == 0
                  ? Center(
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        child: IconButton(
                          padding: const EdgeInsets.all(0),
                          onPressed: () {
                            _pickImage();
                          },
                          icon: Icon(Icons.add),
                        ),
                      ),
                    )
                  : Container(
                      width: double.infinity,
                      height: double.infinity,
                      child: Image.memory(
                        _image[index - 1]!,
                        fit: BoxFit.cover,
                      ),
                    );
            },
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              alignment: Alignment.center,
            ),
            onPressed: () {
              _uploadProductsImagesToStorage();
              _productProvider.getFormData(imageUrlList: _imageUrls);
            },
            child: Text(
              'Upload',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
