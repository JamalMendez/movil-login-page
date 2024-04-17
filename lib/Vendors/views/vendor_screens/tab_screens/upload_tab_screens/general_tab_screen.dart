import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:login_page/provider/product_provider.dart';
import 'package:provider/provider.dart';

class GeneralTabScreen extends StatefulWidget {
  const GeneralTabScreen({super.key});

  @override
  State<GeneralTabScreen> createState() => _GeneralTabScreenState();
}

class _GeneralTabScreenState extends State<GeneralTabScreen> {

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final List<String> _categoryList = [];
  _getCategories() async{
    return _firebaseFirestore.collection('categories').get().then((QuerySnapshot querySnapshot) {
      for (var element in querySnapshot.docs) {
        setState(() {
          _categoryList.add(element['categoryName']);
        });
      }
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
    ProductProvider _productProvider = Provider.of<ProductProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
          children: [
            TextFormField(
            decoration: const InputDecoration(
              labelText: 'Enter Product Name'
              ),
              onChanged: (value){
                _productProvider.getFormData(productName: value);
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Enter Product Price'
              ),
              onChanged: (value){
                _productProvider.getFormData(productPrice: double.parse(value));
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Enter Product Quantity'
              ),
              onChanged: (value){
                _productProvider.getFormData(productQuantity: int.parse(value));
              },
            ),
            DropdownButtonFormField(
              hint: const Text('Select Category'),
              items: _categoryList.map((categories) {
                return DropdownMenuItem(
                  value: categories,
                    child: Text(categories)
                );
              }).toList(),
              onChanged: (value){
                setState(() {
                  _productProvider.getFormData(category: value);
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
              onChanged: (value){
                setState(() {
                  _productProvider.getFormData(description: value);
                });
              },
            ),
            Row(
              children: [
                TextButton(onPressed: (){
                  showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    initialDate: DateTime.now(),
                    lastDate: DateTime(5000), 
                    onDatePickerModeChange: (value) {
                      setState(() {
                        _productProvider.getFormData(scheduleDate: DateTime.parse(value.toString()));
                      });
                    }
                  );
                }, child: const Text(
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
