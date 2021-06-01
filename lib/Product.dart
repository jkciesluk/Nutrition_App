class Product {
  String name='';
  int kcal=0, protein=0, fat=0, carbs =0;
  
  Product(this.name, this.kcal, this.protein, this.fat, this.carbs);

  static Product calculateProduct(Product per_100g, int weight) {
    double mass = weight / 100;
    int kcal = (per_100g.kcal * mass).toInt();
    int protein = (per_100g.protein * mass).toInt();
    int fat = (per_100g.fat * mass).toInt();
    int carbs = (per_100g.carbs * mass).toInt();
    return Product(per_100g.name, kcal, protein, fat, carbs);
  }

  Product.fromJson(Map<String, dynamic> product) {
    this.name = product['name'];
    this.kcal = product['kcal'];
    this.protein = product['protein'];
    this.fat = product['fat'];
    this.carbs = product['carbs'];
    
  }

  Map<String, dynamic> toJson () => {
    'name': name,
    'kcal': kcal,
    'protein': protein,
    'fat': fat,
    'carbs': carbs,
  };

}
