import 'Product.dart';

class SortableProduct {
  Product product = Product('',0,0,0,0);
  double sLevel = 1;

  SortableProduct(this.product, this.sLevel);

  SortableProduct.fromJson(Map<String, dynamic> product) {
    final name = product['name'];
    final kcal = product['kcal'];
    final protein = product['protein'];
    final fat = product['fat'];
    final carbs = product['carbs'];
    this.sLevel = product['sLevel'];
    this.product = Product(name, kcal, protein, fat, carbs);
  }

  Map<String, dynamic> toJson () => {
    
    'name': product.name,
    'kcal': product.kcal,
    'protein': product.protein,
    'fat': product.fat,
    'carbs': product.carbs,
    'sLevel': sLevel,
  };

}