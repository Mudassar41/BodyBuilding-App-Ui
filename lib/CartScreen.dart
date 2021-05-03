import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';

import 'Providers/DatabaseProvider.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  DatabaseProvider _provider;

  @override
  Widget build(BuildContext context) {
    _provider = Provider.of<DatabaseProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Cart",
          style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder(
        future: _provider.getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return Container(
                  height: 130,
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        snapshot.data[index].imageLink),
                                    fit: BoxFit.cover),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              snapshot.data[index].productName,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Text(
                              '${snapshot.data[index].productPrice} \$',
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.blueGrey),
                            ),
                            Row(
                              children: [
                                Text("Total ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blueGrey,
                                        fontSize: 16)),
                                Text(
                                  '${snapshot.data[index].productPrice * snapshot.data[index].productQuantity} \$',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  int id = snapshot.data[index].id;
                                  int quantity =
                                      snapshot.data[index].productQuantity;
                                  quantity = quantity + 1;
                                  _provider.updateCart(id, quantity);
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  elevation: 5,
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    child: Center(
                                        child: Icon(
                                      Icons.add,
                                      size: 18,
                                      color: Colors.blueGrey,
                                    )),
                                  ),
                                ),
                              ),
                              Text(
                                '${snapshot.data[index].productQuantity}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              InkWell(
                                onTap: () {
                                  int id = snapshot.data[index].id;
                                  int quantity =
                                      snapshot.data[index].productQuantity;
                                  if (quantity > 1) {
                                    quantity = quantity - 1;
                                    _provider.updateCart(id, quantity);
                                  }
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  elevation: 5,
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    child: Center(
                                        child: Icon(
                                      Icons.remove,
                                      size: 18,
                                      color: Colors.blueGrey,
                                    )),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return CupertinoActivityIndicator();
        },
      ),
    );
  }
}
