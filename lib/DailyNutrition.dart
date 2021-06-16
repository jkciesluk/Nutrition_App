import 'NewGoalScreen.dart';
import 'package:flutter/material.dart';
import 'Product.dart';
import 'DailyNeeds.dart';
import 'Footer.dart';
import 'AddItemScreen.dart';
import 'CalculatorScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class DailyNutrition extends StatefulWidget {
  @override
  _DailyNutritionState createState() => _DailyNutritionState();
}



class _DailyNutritionState extends State<DailyNutrition> {
  
  final List<Product> _eatenToday = <Product>[];
  
  @override
  //@mustCallSuper
  void initState() {
    super.initState();
    _readDailyNeeds();
    _readObjects();
  }


  void _saveDailyNeeds () async {
    final String savedKey = 'dailyNeeds';
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString(savedKey, jsonEncode(totalDailyNeeds));
  }
  

  void _readDailyNeeds () async {
    final String savedKey = 'dailyNeeds';
    SharedPreferences sp = await SharedPreferences.getInstance();
    final toDecode = sp.getString(savedKey);

    setState(() {
        
      if(toDecode != null) {
        totalDailyNeeds = new DailyNeeds.fromJson(jsonDecode(toDecode)) ;
      }
      });
  }

  
  void _saveObjects () async {
    final String savedKey = 'productsEatenToday';
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString(savedKey, jsonEncode(_eatenToday));
  }

  void _readObjects () async {
    final String savedKey = 'productsEatenToday';
    SharedPreferences sp = await SharedPreferences.getInstance(); 
      final toDecode = sp.getString(savedKey);
      setState(() {
        
      
      if(toDecode != null) {
        _eatenToday.clear();
        jsonDecode(toDecode).forEach((map) => _eatenToday.add(new Product.fromJson(map)));
      }
      }); 
  }

  Widget _buildProductTile(Product product) {
    return ListTile(
      title: Text('${product.name}'),
      subtitle: Text('${product.kcal} kcal, ${product.protein} P, ${product.fat} F, ${product.carbs} C'),
      trailing: IconButton(
        onPressed: () {
          _removeItem(product);
        }, 
        icon: Icon(Icons.remove)),
    );
  }

  
  


  Widget _buildList() {
    // _readObjects();
      //_eatenToday.add(Product('Apple', 100, 20, 30,50));
    currentDailyNeeds = DailyNeeds.calculateTotal(_eatenToday);
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: _eatenToday.length * 2,
      itemBuilder: (context, i) {
        if(i.isOdd) return Divider();
        final index = i~/2;
        return _buildProductTile(_eatenToday[index]);
      }
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nutrition App'),
        actions: [
          IconButton(onPressed: _pushCalculator, icon: Icon(Icons.calculate)),
          IconButton(onPressed: _pushNewGoal, icon: Icon(Icons.settings)),
          IconButton(onPressed: _clearAllButtonCall, icon: Icon(Icons.clear)),
        ],
      ),
      body: _buildList(),
      bottomNavigationBar: Footer(),
      floatingActionButton: FloatingActionButton(
        onPressed: _pushSearchPage,
        child: Icon(Icons.add),
      ),
      );
  }


  void _clearAllButtonCall() {
    showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Are you sure you want to clear the list?'),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(onPressed: _clearAllItems, child: Text('Yes'),),
                        ElevatedButton(onPressed: () => Navigator.pop(context), child: Text('No'),),
                      ],
                    )
                  ],
                )
              );
            },
          );
    }

  void _clearAllItems() {
    setState(() {
      _eatenToday.clear();
      _saveObjects();
    });
    Navigator.pop(context);
  }



  void _removeItem(Product product) {
    showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Are you sure you want to delete this item?'),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _eatenToday.remove(product); 
                              _saveObjects();
                              Navigator.pop(context);
                          });
                          }, 
                          child: Text('Yes'),),
                        ElevatedButton(onPressed: () => Navigator.pop(context), child: Text('No'),),
                      ],
                    )
                  ],
                )
              );
            },
          );
    }


  void _pushSearchPage() async {
    
    final result = await Navigator.push(context, 
            MaterialPageRoute(
              builder: (context) => AddItemScreen()),);
             //refresh the state of your Widget
                 setState(() {
              if(result != null)
                _eatenToday.addAll(result);
                _saveObjects();
            });
  }

  
  void _pushCalculator() async {
    
    final result = await Navigator.push(context, 
            MaterialPageRoute(
              builder: (context) => CalculatorScreen()),);
             //refresh the state of your Widget
                 setState(() {
              if(result != null) {
                totalDailyNeeds = result;
                _saveDailyNeeds();
              }
            });
  }
  void _pushNewGoal() async {
    final result = await Navigator.push(context, 
            MaterialPageRoute(
              builder: (context) => NewGoalScreen()),);
             //refresh the state of your Widget
                 setState(() {
              if(result != null) {     
                totalDailyNeeds = result;
                _saveDailyNeeds();
              }
            });
  }
}


