import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GeneralTabScreen extends StatefulWidget {
  const GeneralTabScreen({super.key});

  @override
  State<GeneralTabScreen> createState() => _GeneralTabScreenState();
}

class _GeneralTabScreenState extends State<GeneralTabScreen> {

  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  List<String> _categoryList = [];
  _getCategories() async{
    return _firebaseFirestore.collection('categories').get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((element) {
        setState(() {
          _categoryList.add(element['categoryName']);
        });
      });
    });
  }

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    _getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
          children: [
            TextFormField(
            decoration: InputDecoration(
            labelText: 'Enter Product Name'
            ),
            ),
            TextFormField(
              decoration: InputDecoration(
                  labelText: 'Enter Product Price'
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                  labelText: 'Enter Product Quantity'
              ),
            ),
            DropdownButtonFormField(
              hint: Text('Select Category'),
              items: _categoryList.map((categories) {
                return DropdownMenuItem(
                  value: categories,
                    child: Text(categories)
                );
              }).toList(),
              onChanged: (value){
                setState(() {

                });
              },

            ),
            TextFormField(
              maxLines: 4,
              maxLength: 200,
              decoration: InputDecoration(
                labelText: 'Enter Product Description',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Row(
              children: [
                TextButton(onPressed: (){
                  showDatePicker(context: context, firstDate: DateTime.now(), initialDate: DateTime.now(), lastDate: DateTime(5000));
                }, child: Text(
                    'Schedule',
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
                ),
              ],
            )

          ],
          ),
        );
  }
}
