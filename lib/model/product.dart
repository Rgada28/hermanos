class Product {
  int id;
  String title;
  double price;
  String description;
  String category;
  String image;
  Rating rating;
  Product(
      {required this.id,
      required this.title,
      required this.price,
      required this.description,
      required this.category,
      required this.image,
      required this.rating});

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      title: map['title'],
      price: map['price'].toDouble(),
      description: map['description'],
      category: map['category'],
      image: map['image'],
      rating: Rating.fromMap(map['rating']),
    );
  }

  // Convert a Product object to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'category': category,
      'image': image,
      'rating': rating.toMap(),
    };
  }
}

class Rating {
  double rate;
  int count;

  Rating({
    required this.rate,
    required this.count,
  });

  // Convert a Map to a Rating object
  factory Rating.fromMap(Map<String, dynamic> map) {
    return Rating(
      rate: map['rate'].toDouble(),
      count: map['count'],
    );
  }

  // Convert a Rating object to a Map
  Map<String, dynamic> toMap() {
    return {
      'rate': rate,
      'count': count,
    };
  }
}
