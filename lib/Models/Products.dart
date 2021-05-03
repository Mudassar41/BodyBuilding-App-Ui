class Cart {
  List<Products> data;

  Cart({this.data});

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      data: json['data'] as List,
    );
  }
}

class Products {
  int id;
  String productName;
  String imageLink;
  int productPrice;
  int productQuantity;

  Products.add(this.id, this.productName, this.imageLink, this.productPrice);

  Products(
      {this.id,
      this.productName,
      this.imageLink,
      this.productPrice,
      this.productQuantity});

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
      id: json['id'],
      productName: json['productName'],
      imageLink: json['imageLink'],
      productPrice: json['productPrice'],
      productQuantity: json['productQuantity'],
    );
  }
}
