import 'package:flutter/material.dart';
import 'SortableProduct.dart';
import 'Product.dart';
class AddSuggestionScreen extends StatefulWidget {
  const AddSuggestionScreen({Key? key}) : super(key: key);

  @override
  State<AddSuggestionScreen> createState() => _AddSuggestionScreenState();
}

class _AddSuggestionScreenState extends State<AddSuggestionScreen> {

  final nameController = TextEditingController();
  final kcalController = TextEditingController();
  final proteinController = TextEditingController();
  final fatController = TextEditingController();
  final carbsController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    kcalController.dispose();
    fatController.dispose();
    proteinController.dispose();
    carbsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context),),
        title: Text('Add new product to database'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 40.0,),
        
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter product name'
              ),
              controller: nameController,
            ),
            TextFormField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter kcal per 100g'
              ),
              controller: kcalController,
            ),
            TextFormField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter protein per 100g'
              ),
              controller: proteinController,
            ),
            TextFormField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter fat per 100g'
              ),
              controller: fatController,
            ),
            TextFormField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter carbs per 100g',
              ),
              controller: carbsController,
            ),
            
          ],
        ),
      ),
      
      
      floatingActionButton: FloatingActionButton(
        // When the user presses the button, show an alert dialog containing
        // the text that the user has entered into the text field.
        onPressed: () {
          final name = nameController.text;
          final kcal = int.tryParse(kcalController.text)!;
          final protein = int.tryParse(proteinController.text)!;
          final fat = int.tryParse(fatController.text)!;
          final carbs = int.tryParse(carbsController.text)!;
          final newSortableProduct = SortableProduct(Product(name, kcal, protein, fat, carbs), 0);
          Navigator.pop(context, newSortableProduct);
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                
                content: Text('New product added'),
              );
            },
          );
        },
        tooltip: 'Add new product',
        child: Icon(Icons.add),
      ),
      
    );
  }
}