class ProductResponse {
  ProductResponse({
    required this.status,
    required this.results,
    required this.data,
    required this.message,
  });
  late final String status;
  late final int results;
  late final Data data;
  late final String message;

  ProductResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    results = json['results'];
    data = Data.fromJson(json['data']);
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['results'] = results;
    _data['data'] = data.toJson();
    _data['message'] = message;
    return _data;
  }
}

class Data {
  Data({
    required this.product,
  });
  late final List<Product> product;

  Data.fromJson(Map<String, dynamic> json) {
    product =
        List.from(json['product']).map((e) => Product.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['product'] = product.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Product {
  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.stock,
    required this.createDate,
    required this.category,
  });
  late final int id;
  late final String name;
  late final String image;
  late final String price;
  late final int stock;
  late final int createDate;
  late final List<String> category;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    price = json['price'];
    stock = json['stock'];
    createDate = json['createDate'];
    category = List.castFrom<dynamic, String>(json['category']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['image'] = image;
    _data['price'] = price;
    _data['stock'] = stock;
    _data['createDate'] = createDate;
    _data['category'] = category;
    return _data;
  }
}

// CARTPRODUCT
class CartProduct {
  final int? id;
  final String? name;
  final String? price;
  final String? image;
  final int? quantity;

  CartProduct(
      {required this.id,
      required this.name,
      required this.price,
      required this.quantity,
      required this.image});

  CartProduct.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        name = res["name"],
        price = res["price"],
        quantity = res["quantity"],
        image = res["image"];

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'image': image,
      'quantity': quantity
    };
  }
}
