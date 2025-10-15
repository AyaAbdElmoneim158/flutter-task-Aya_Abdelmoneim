// models/product.dart
class Product {
  final int? id;
  final String name;
  final double price;
  final double? oldPrice;
  final String image;
  final bool freeShipping;
  final int categoryId;

  Product({
    this.id,
    required this.name,
    required this.price,
    this.oldPrice,
    required this.image,
    required this.freeShipping,
    required this.categoryId,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      price: map['price'],
      oldPrice: map['oldPrice'],
      image: map['image'],
      freeShipping: map['freeShipping'] == 1,
      categoryId: map['categoryId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'oldPrice': oldPrice,
      'image': image,
      'freeShipping': freeShipping ? 1 : 0,
      'categoryId': categoryId,
    };
  }

// otex_app\assets\test_test_images
  static List<Product> sampleProducts = [
    Product(
      name: 'ثلاجة سامسونج',
      price: 4500,
      oldPrice: 5000,
      image: 'assets/test_images/fridge.jpg', //cached_image
      freeShipping: true,
      categoryId: 1, // أجهزة كهربائية
    ),
    Product(
      name: 'غسالة LG',
      price: 3200,
      oldPrice: 3500,
      image: 'assets/test_images/washing_machine.jpg',
      freeShipping: true,
      categoryId: 1, // أجهزة كهربائية
    ),
    Product(
      name: 'كنبة 3 مقاعد',
      price: 2500,
      image: 'assets/test_images/sofa.jpg',
      freeShipping: false,
      categoryId: 2, // أثاث
    ),
    Product(
      name: 'طاولة طعام',
      price: 1800,
      image: 'assets/test_images/table.jpg',
      freeShipping: false,
      categoryId: 2, // أثاث
    ),
    Product(
      name: 'أسمنت مسلح',
      price: 850,
      image: 'assets/test_images/cement.jpg',
      freeShipping: true,
      categoryId: 3, // مواد بناء
    ),
    Product(
      name: 'بلاط سيراميك',
      price: 120,
      image: 'assets/test_images/ceramic.jpg',
      freeShipping: false,
      categoryId: 6, // سيراميك
    ),
  ];
}
