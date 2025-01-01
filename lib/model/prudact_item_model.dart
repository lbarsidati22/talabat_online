class PrudactItemModel {
  final String name;
  final String id;
  final String imgUrl;
  final String description;
  final double price;
  final bool isFavorite;
  final String category;
  final double avrageRate;

  PrudactItemModel({
    this.avrageRate = 4.5,
    required this.name,
    required this.id,
    required this.imgUrl,
    this.description =
        'Our Coordinate collection is inspired by unique eye-drawing colors found in Miami, pinning the exact location this set was designed. This hoodie features a Super Soft Combed Cotton Blend™, a kangaroo pocket and an oversized double-lined hood. Each hoodie undergoes an enzyme wash to enhance its softness and deliver the absolute best quality. Our hoodies are slightly weighted and oversized which many customers claim has helped with their anxiety/stress.',
    required this.price,
    this.isFavorite = false,
    required this.category,
  });

  PrudactItemModel copyWith({
    String? name,
    String? id,
    String? imgUrl,
    String? description,
    double? price,
    bool? isFavorite,
    String? category,
    double? avrageRate,
  }) {
    return PrudactItemModel(
      name: name ?? this.name,
      id: id ?? this.id,
      imgUrl: imgUrl ?? this.imgUrl,
      description: description ?? this.description,
      price: price ?? this.price,
      isFavorite: isFavorite ?? this.isFavorite,
      category: category ?? this.category,
      avrageRate: avrageRate ?? this.avrageRate,
    );
  }
}

List<PrudactItemModel> dummyProducts = [
  PrudactItemModel(
    id: 'TUbtVrVcMNHpZF33cxKC',
    name: 'Black Shoes',
    imgUrl: 'https://pngimg.com/d/men_shoes_PNG7475.png',
    price: 20,
    category: 'Shoes',
  ),
  PrudactItemModel(
    id: 'zuHIOlufjUFsacVn48kt',
    name: 'Trousers',
    imgUrl:
        'https://www.pngall.com/wp-content/uploads/2016/09/Trouser-Free-Download-PNG.png',
    price: 30,
    category: 'Clothes',
  ),
  PrudactItemModel(
    id: 'bHCwRrySeNqDFIRzZKZa',
    name: 'Pack of Tomatoes',
    imgUrl:
        'https://parspng.com/wp-content/uploads/2022/12/tomatopng.parspng.com-6.png',
    price: 10,
    category: 'Groceries',
  ),
  PrudactItemModel(
    id: 'vkvvuIrQM7dGYSXFkkQs',
    name: 'Pack of Potatoes',
    imgUrl: 'https://pngimg.com/d/potato_png2398.png',
    price: 10,
    category: 'Groceries',
  ),
  PrudactItemModel(
    id: 'a2hSaD88h9OnOd0NGAaK',
    name: 'Pack of Onions',
    imgUrl: 'https://pngimg.com/d/onion_PNG99213.png',
    price: 10,
    category: 'Groceries',
  ),
  PrudactItemModel(
    id: 'wWBXvZt0rPPpinXjbzTI',
    name: 'Pack of Apples',
    imgUrl: 'https://pngfre.com/wp-content/uploads/apple-43-1024x1015.png',
    price: 10,
    category: 'Fruits',
  ),
  PrudactItemModel(
    id: 'VG6N3kHfRyb7GptZb8B5',
    name: 'Pack of Oranges',
    imgUrl:
        'https://parspng.com/wp-content/uploads/2022/05/orangepng.parspng.com_-1.png',
    price: 10,
    category: 'Fruits',
  ),
  PrudactItemModel(
    id: 'HDuUqvyuXoXwbmevi9kB',
    name: 'Pack of Bananas',
    imgUrl:
        'https://static.vecteezy.com/system/resources/previews/015/100/096/original/bananas-transparent-background-free-png.png',
    price: 10,
    category: 'Fruits',
  ),
  PrudactItemModel(
    id: 'XxIge7JfwnXGCYm26MoJ',
    name: 'Pack of Mangoes',
    imgUrl: 'https://purepng.com/public/uploads/large/mango-tgy.png',
    price: 10,
    category: 'Fruits',
  ),
  PrudactItemModel(
    id: 's4pMZiAh7i4S8rdavVHT',
    name: 'Sweet Shirt',
    imgUrl:
        'https://www.usherbrand.com/cdn/shop/products/5uYjJeWpde9urtZyWKwFK4GHS6S3thwKRuYaMRph7bBDyqSZwZ_87x1mq24b2e7_1800x1800.png',
    price: 15,
    category: 'Clothes',
  ),
];
