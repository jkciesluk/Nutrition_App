import 'Product.dart';
import 'package:flutter/material.dart';

class AddSelectedItemScreen extends StatefulWidget {

  final Product product;
  AddSelectedItemScreen(this.product);
  _AddSelectedItemScreenState createState() => _AddSelectedItemScreenState(product);
}

class _AddSelectedItemScreenState extends State<AddSelectedItemScreen> {
  final weightController = TextEditingController();
  
  _AddSelectedItemScreenState(this.product);
  final Product product;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context),),
        title: Text('Add New Item', ),
      ),
      body: Padding(
        
        padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 40.0,),
        
        child: Column(
          
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Add New Item', style: TextStyle(fontSize: 20, ),),
            SizedBox(height: 10),
            
            Text('${product.name}', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),),
            
            SizedBox(height: 10),
            Text('${product.kcal} kcal    ${product.protein} P    ${product.fat} F    ${product.carbs} C', style: TextStyle(fontSize: 16),),
            Text('per 100g', style: TextStyle(fontSize: 14),),
            SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter amount in g',
              ),
              controller: weightController,
            ),
                        
          ],
        ),
      ),
      
      floatingActionButton: FloatingActionButton(
        // When the user presses the button, show an alert dialog containing
        // the text that the user has entered into the text field.
        onPressed: () {setState(() {
          
        
          final weight = int.tryParse(weightController.text)!;
          //totalDailyNeeds = DailyNeeds.calculateDailyNeeds(weight, height, age, activityLevel);
          final newItem = Product.calculateProduct(this.product, weight);
          Navigator.pop(context, newItem);
          });
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                
                content: Text('Item added'),
              );
            },
          );
        },
        tooltip: 'Add Item',
        child: Icon(Icons.add),
      ),
      
    );
  }
}