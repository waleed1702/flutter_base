class DbProducts {
  String name;
  String price;
  String id;
  DbProducts({
    required this.id,
    required this.name,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'price': price,
    };
  }

  static fromMap(Map<String, dynamic> map) {
    return DbProducts(
      id: map['id'],
      name: map['name'],
      price: map['price'],
    );
  }
}
