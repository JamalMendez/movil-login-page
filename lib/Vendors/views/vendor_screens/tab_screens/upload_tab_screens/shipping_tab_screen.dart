import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_page/provider/product_provider.dart';
import 'package:provider/provider.dart';

class ShippingTabScreen extends StatefulWidget {
  const ShippingTabScreen({super.key});

  @override
  State<ShippingTabScreen> createState() => _ShippingTabScreenState();
}

class _ShippingTabScreenState extends State<ShippingTabScreen> {
  bool? _shippingCharge = false;


  @override
  Widget build(BuildContext context) {
    ProductProvider _productProvider = Provider.of<ProductProvider>(context);
    return Column(
      children: [
        CheckboxListTile(
          title: Text('Charge Shipping?', style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          )),
          value: _shippingCharge,
          onChanged: (value){
            setState(() {
              _shippingCharge = value;
              _productProvider.getFormData(shippingCharge: value);
            });
          },
        ),
        _shippingCharge == true ?
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
            child: TextField(
                keyboardType: TextInputType.number,
                onChanged: (value){
                  setState(() {
                    if(value.isNotEmpty){
                      _productProvider.getFormData(shippingChargeValue: double.parse(value));
                    }
                  });
                },
            ),
          ) :
            Text('')

      ],
    );
  }
}
