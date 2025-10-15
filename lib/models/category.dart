class Category {
  final int? id;
  final String name;

  Category({
    this.id,
    required this.name,
  });

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'],
      name: map['name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  static List<Category> categories = [
    Category(id: 0, name: "كل العروض"),
    Category(id: 1, name: "ملابس"),
    Category(id: 2, name: "إكسسوارات"),
    Category(id: 3, name: "إلكترونيات"),
    Category(id: 4, name: "منتجات تجميل"),
    Category(id: 5, name: "موبايلات"),
    Category(id: 6, name: "ساعات"),
    Category(id: 7, name: "موضة رجالي"),
  ];
}
