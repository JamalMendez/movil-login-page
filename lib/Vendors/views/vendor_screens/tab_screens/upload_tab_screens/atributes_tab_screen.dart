import 'package:flutter/material.dart';
import 'package:login_page/provider/product_provider.dart';
import 'package:provider/provider.dart';

class AtributesTabScreens extends StatefulWidget {
  const AtributesTabScreens({super.key});

  @override
  State<AtributesTabScreens> createState() => _AtributesTabScreensState();
}

class _AtributesTabScreensState extends State<AtributesTabScreens> {

  TextEditingController _sizeEdititingController = TextEditingController();
  bool showSizeButton = false;
  List<String> _sizeValues = [];


  @override
  Widget build(BuildContext context) {
    ProductProvider _productProvider = Provider.of<ProductProvider>(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextFormField(
            decoration: InputDecoration(labelText: 'Brand'),
            onChanged: (value){
              _productProvider.getFormData(brand: value);
            },
          ),
        ),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                width: 200,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    controller: _sizeEdititingController,
                    onChanged: (value) {
                      setState(() {
                        if (value.isNotEmpty) {
                          showSizeButton = true;
                        } else {
                          showSizeButton = false;
                        }
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Add a Size',
                    ),
                  ),
                ) ,
              ),
            ),
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: showSizeButton
                      ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),

                    onPressed: () {
                      setState(() {
                        _sizeValues.add(_sizeEdititingController.text);
                        _sizeEdititingController.clear();
                      });
                    },
                    child: Text('Add'),
                  )
                      : null,
                )),
          ],
        ),
        _sizeValues.isNotEmpty
            ? Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 50,
            child: ListView.builder(
              itemCount: _sizeValues.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      _sizeValues.removeAt(index);
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.blue.shade800,
                          borderRadius:
                          BorderRadius.circular(10.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          _sizeValues[index],
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        )
            : Text(''),
      ],
    );
  }
}
