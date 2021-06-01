import 'package:flutter/material.dart';
import 'DailyNeeds.dart';

class CalculatorScreen extends StatefulWidget {

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {

  final weightController = TextEditingController();
  final heightController = TextEditingController();
  final ageController = TextEditingController();
  final activityController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    weightController.dispose();
    ageController.dispose();
    heightController.dispose();
    activityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context),),
        title: Text('Calculate your new goal'),
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
                labelText: 'Enter your weight'
              ),
              controller: weightController,
            ),
            TextFormField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter your age'
              ),
              controller: ageController,
            ),
            TextFormField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter your height'
              ),
              controller: heightController,
            ),
            TextFormField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter your level of activity (1.0 - 2.0)',
              ),
              controller: activityController,
            ),
            
          ],
        ),
      ),
      
      floatingActionButton: FloatingActionButton(
        // When the user presses the button, show an alert dialog containing
        // the text that the user has entered into the text field.
        onPressed: () {setState(() {
          
        
          final weight = double.tryParse(weightController.text)!;
          final height = double.tryParse(heightController.text)!;
          final age = double.tryParse(ageController.text)!;
          final activityLevel = double.tryParse(activityController.text)!;
          //totalDailyNeeds = DailyNeeds.calculateDailyNeeds(weight, height, age, activityLevel);
          final newNeeds = DailyNeeds.calculateDailyNeeds(weight, height, age, activityLevel);
          Navigator.pop(context, newNeeds);
          });
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                
                content: Text('New goal submitted'),
              );
            },
          );
        },
        tooltip: 'Calculate new goal',
        child: Icon(Icons.add),
      ),
      
    );
  }
}