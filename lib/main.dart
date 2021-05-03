import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_grid_delegate_ext/rendering/grid_delegate.dart';
import 'package:provider/provider.dart';
import 'package:shopingcart_nodejs/CartScreen.dart';

import 'Models/Products.dart';
import 'Providers/DatabaseProvider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<DatabaseProvider>(
          create: (BuildContext context) {
            return DatabaseProvider();
          },
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Cart(),
    );
  }
}

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  DatabaseProvider _provider;

  List<Products> productList = [
    Products.add(1, ' Dockers Shoes', 'assets/shoes.jpg', 399),
    Products.add(2, 'Shelter Shoes', 'assets/shoes1.jpg', 399),
    Products.add(3, 'Shelter Shoes', 'assets/shoes3.png', 389),
  ];

  @override
  Widget build(BuildContext context) {
    _provider = Provider.of<DatabaseProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              Icons.shopping_cart_sharp,
              color: Colors.blue,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CartScreen()),
              );
            },
          )
        ],
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Shopping Cart  Nodejs",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
        ),
      ),
      body: GridView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: productList.length,
          gridDelegate: XSliverGridDelegate(
            crossAxisCount: 2,
            smallCellExtent: 210,
            bigCellExtent: 210,
            mainAxisSpacing: 2,
            crossAxisSpacing: 2,
          ),
          itemBuilder: (context, index) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              clipBehavior: Clip.antiAlias,
              elevation: 5,
              child: InkWell(
                splashColor: Colors.green,
                onTap: () {},
                child: Column(
                  children: [
                    Container(
                      height: 150,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      child: Stack(
                        children: [
                          Center(child: CupertinoActivityIndicator()),
                          Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(5),
                                      bottomRight: Radius.circular(5)),
                                  image: DecorationImage(
                                      image: AssetImage(
                                          productList[index].imageLink),
                                      fit: BoxFit.cover))),
                          Positioned(
                            top: 0,
                            left: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                    color: Colors.white54,
                                    shape: BoxShape.rectangle),
                                child: Center(
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.shopping_cart,
                                      color: Colors.black54,
                                    ),
                                    onPressed: () {
                                      int id = productList[index].id;
                                      String name =
                                          productList[index].productName;
                                      String link =
                                          productList[index].imageLink;
                                      int price =
                                          productList[index].productPrice;
                                      int qty = productList[index]
                                          .productQuantity = 1;
                                      int newqty = qty;
                                      _provider.addToCart(id,name,link,price,newqty);
                                    },
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        productList[index].productName.toUpperCase(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '${productList[index].productPrice} \$',
                      style: TextStyle(
                          fontWeight: FontWeight.normal, color: Colors.red),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
