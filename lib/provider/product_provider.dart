
import 'package:flutter/cupertino.dart';

class ProductProvider with ChangeNotifier{
  Map<String, dynamic> productData = {};

  getFormData({
    String? productName,
    double? productPrice,
    int? productQuantity,
    String? category,
    String? description,
    DateTime? scheduleDate,
    List<String>? imageUrlList,
    bool? shippingCharge,
    double? shippingChargeValue,
    String? brand
}){
    if(productName != null){
      productData['productName'] = productName;
    }
    if(productName != null){
      productData['productPrice'] = productPrice;
    }
    if(productName != null){
      productData['productQuantity'] = productQuantity;
    }
    if(productName != null){
      productData['category'] = category;
    }
    if(productName != null){
      productData['description'] = description;
    }
    if(productName != null){
      productData['scheduleDate'] = scheduleDate;
    }
    if(productName != null){
      productData['imageUrlList'] = imageUrlList;
    }
    if(productName != null){
      productData['shippingCharge'] = shippingCharge;
    }
    if(productName != null){
      productData['shippingChargeValue'] = shippingChargeValue;
    }
    if(productName != null){
      productData['brand'] = brand;
    }

  }
}