import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shopingcart_nodejs/Models/Products.dart';

class DatabaseProvider extends ChangeNotifier {
  String addDataUrl = "http://192.168.43.31:4000/Cart/Add";
  String getDataUrl = 'http://192.168.43.31:4000/Cart/get';
  String updateDataUrl = 'http://192.168.43.31:4000/Cart/update';

  Future<void> addToCart(
      int id, String name, String link, int price, int newqty) async {
    final http.Response response = await http.post(addDataUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'id': id,
          'productName': name,
          'productQuantity': newqty,
          'imageLink': link,
          'productPrice': price,
        }));
    if (response.statusCode == 200) {
      var value = jsonDecode(response.body);
      print(value);
    } else {
      var value = jsonDecode(response.body);
      print(value);
    }
  }

  Future<List<Products>> getData() async {
    //  print("yes");
    var response = await http.get(getDataUrl);

    final data = jsonDecode(response.body);
    var newlist = data['data'];

    List<Products> list =
        newlist.map<Products>((json) => Products.fromJson(json)).toList();
    // print(list.length);
    notifyListeners();
    return list;
  }

  Future<void> updateCart(int id, int newqty) async {
    final http.Response response = await http.post(updateDataUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'id': id,
          'productQuantity': newqty,
        }));
    if (response.statusCode == 200) {
      var value = jsonDecode(response.body);
      print(value);
    } else {
      var value = jsonDecode(response.body);
      print(value);
    }
  }
}
