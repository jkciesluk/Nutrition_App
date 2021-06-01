import 'package:flutter/material.dart';
import 'DailyNeeds.dart';

class NewGoalScreen extends StatefulWidget {
  const NewGoalScreen({Key? key}) : super(key: key);

  @override
  State<NewGoalScreen> createState() => _NewGoalScreenState();
}

class _NewGoalScreenState extends State<NewGoalScreen> {

  final kcalController = TextEditingController();
  final proteinController = TextEditingController();
  final fatController = TextEditingController();
  final carbsController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
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
        title: Text('Enter your new goal'),
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
                labelText: 'Enter kcal'
              ),
              controller: kcalController,
            ),
            TextFormField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter protein'
              ),
              controller: proteinController,
            ),
            TextFormField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter fat'
              ),
              controller: fatController,
            ),
            TextFormField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter carbs',
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
          final kcal = int.tryParse(kcalController.text)!;
          final protein = int.tryParse(proteinController.text)!;
          final fat = int.tryParse(fatController.text)!;
          final carbs = int.tryParse(carbsController.text)!;
          final newNeeds = DailyNeeds(kcal, protein, fat, carbs);
          Navigator.pop(context, newNeeds);
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