class Product {
  String? id;
  String? name;
  double? price;

  Product({this.id, this.name, this.price});

  Product.map(dynamic obj) {
    id = obj['id'];
    name = obj['name'];
    price = obj['price'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    if (id != null) {
      map['id'] = id;
    }
    map['name'] = name;
    map['price'] = price;
    return map;
  }

  Product.fromMap(Map<String, dynamic> map, String? id) {
    id = id ?? '';
    name = map['name'];
    price = map['price'];
  }
}
