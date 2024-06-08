

class ProductModel {
  String id;
  String name;
  String image;
  String type;
  double price;

//<editor-fold desc="Data Methods">
  ProductModel({
    required this.id,
    required this.name,
    required this.image,
    required this.type,
    required this.price,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          image == other.image &&
          type == other.type &&
          price == other.price);

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ image.hashCode ^ type.hashCode ^ price.hashCode;

  @override
  String toString() {
    return 'ProductModel{ id: $id, name: $name, image: $image, type: $type, price: $price,}';
  }

  ProductModel copyWith({
    String? id,
    String? name,
    String? image,
    String? type,
    double? price,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      type: type ?? this.type,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'image': this.image,
      'type': this.type,
      'price': this.price,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] as String,
      name: map['name'] as String,
      image: map['image'] as String,
      type: map['type'] as String,
      price: map['price'] as double,
    );
  }

//</editor-fold>
}