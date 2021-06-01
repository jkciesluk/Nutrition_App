import 'Product.dart';

class DailyNeeds {
  int kcal=0;
  int protein=0;
  int fat=0;
  int carbs=0;

  DailyNeeds(this.kcal, this.protein, this.fat, this.carbs);



  DailyNeeds.fromJson(Map<String, dynamic> needs) {
    this.kcal = needs['kcal'];
    this.protein = needs['protein'];
    this.fat = needs['fat'];
    this.carbs = needs['carbs'];
    
  }

  Map<String, dynamic> toJson () => {
    'kcal': kcal,
    'protein': protein,
    'fat': fat,
    'carbs': carbs,
  };




  static double _calculateBMR(double weight, double height, double age) {
    return 10 * weight + 6.25 * height - 5 * age + 90;
  }

  static DailyNeeds calculateDailyNeeds(double weight, double height, double age, double activityLevel) {
    final bmr = _calculateBMR(weight, height, age);
    final tef = 0.1 * bmr;
    final eee = (activityLevel - 1) * bmr;
    final int kcal = (bmr + tef + eee).round();
    //final protein = (kcal / 16).round(); // 25% of calories, 1 g of protein is 4 kcal
    //final fat = (kcal / 36).round(); // 25% of calories, 1 g of fat is 9 kcal
    //final carbs = (kcal / 16).round(); // 25% of calories, 1 g of carbohydrates is 4 kcal
    final int protein = (2* weight).round();
    final int fat = weight.round();
    final int carbs = (kcal - 4*protein - 9*fat) ~/ 4;
    
    return DailyNeeds(kcal, protein, fat, carbs);
  }

  static DailyNeeds calculatefromKcal (int kcal) {
    final protein = (kcal / 16).round(); // 25% of calories, 1 g of protein is 4 kcal
    final fat = (kcal / 36).round(); // 25% of calories, 1 g of fat is 9 kcal
    final carbs = (kcal / 16).round(); // 25% of calories, 1 g of carbohydrates is 4 kcal
    return DailyNeeds(kcal, protein, fat, carbs);  
  }

  static DailyNeeds calculateTotal(List<Product> _eatenToday) {
    int kcal=0, protein=0, fat=0, carbs=0;
    _eatenToday.forEach((product) {
      kcal+=product.kcal;
      protein+=product.protein;
      fat+=product.fat;
      carbs+=product.carbs;
     });
     return DailyNeeds(kcal, protein, fat, carbs);
  }
}

DailyNeeds currentDailyNeeds = DailyNeeds(0,0,0,0);
DailyNeeds totalDailyNeeds = DailyNeeds(2000, 80, 80, 250);

